# Agent-loop trace

Parsed from `logs/test-2/pi-loop.log`. The file is produced by a custom Pi
extension written for exactly this purpose: it traces the whole request/response
lifecycle of the agent loop, with millisecond deltas at every step. It is not a
model-server log and does not come from llama.cpp.

What it records per turn: the outgoing system prompt and tool schemas, the HTTP
header response, the arrival of the first streamed chunk, the model's thinking
block, each tool result, and the turn boundary. That is what makes the
client-side timings in this file available at all, since `llama.log` only sees
the request arrive and the tokens leave.

It is the counterpart to `llama.log`: the server log shows what the GPU did,
this one shows what the agent actually waited for.

## Server configuration this trace ran against

```text
n_slots      = 4
n_ctx_slot   = 131072
kv_unified   = true
n_threads    = 6
```

This is **not** the configuration in `run-observed.sh`, which documents the
`--parallel 1`, `--threads 4` run recorded in `logs/test-1`. The trace above is
what the startup lines of `llama.log` actually print for this run.

Be precise about what is observed and what is inferred. `n_slots = 4` and
`n_threads = 6` are read straight from the log. The flag that produced
`n_slots = 4` was **not** recorded for this run: there is no command line in
either `llama.log` or `pi-loop.log` for test-2, so `--parallel 4` is an inference
from `n_slots`, not an observation. The 88 occurrences of `--parallel 1` inside
`pi-loop.log` are not evidence about this run either; they are the agent reading
`run-observed.sh`, replayed once per turn in the re-sent transcript.

With 33 sequential requests from a single client, every request was served by
slot 3 and slots 0-2 stayed idle the whole session, so the extra slots were
never exercised.

`n_ctx_slot` stayed at 131072 and the run never reported `truncated = 1`, so the
slot count did not cost this session any context. What cannot be ruled out from
these two logs is whether the slot count and thread count changed the per-token
cost; the cold prefill numbers are close (97.64 vs 95.53 tok/s) while the warm
generation figures differ more (12.0-12.3 vs a 9.40 median). That is a comparison
across two runs with different prompt shapes and turn counts, not a controlled
A/B.

## Session shape

```text
system prompt size   = 33927 chars
skills loaded        = 29
context files        = 1
selected tools       = 35
turns                = 33
tool results         = 34
model responses      = 3
wall clock (first request to last turn) = 55.7 min
wall clock between turn boundaries      = 53.2 min
```

One user request drove 33 agent turns. Almost every turn produced exactly one
tool call: the loop was nearly always "call one tool, read one result, decide
again". Only 3 of the 33 turns ended with a user-facing message.

## Time to first token

Measured client-side, from sending the request to the first token of the stream:

```text
cold turn (turn 0)   = 269458 ms  (4m29s)
warm turns min       =   1503 ms
warm turns median    =   6260 ms
warm turns p75       =  12941 ms
warm turns p90       =  18086 ms
warm turns max       = 139917 ms  (2m20s)
```

The cold turn is 4m29s of silence before a single token arrives. After that the
floor at 1.5s is the cached-prefix fast path; the spread up to 2m20s is prefill
for whatever new context the previous tool call appended.

The 139.9s outlier is turn 4, which is also the longest turn of the session at
1353s.

## Per-turn wall clock

```text
turn  4   1353.0 s   1 tool    <- single largest turn, half the session
turn  5    155.0 s   1 tool
turn 27    155.0 s   1 tool
turn 32    140.0 s   0 tools   <- final answer, no tool call
turn 25    134.0 s   1 tool
turn 28    131.0 s   1 tool
turn  9    118.0 s   1 tool
turn  6    116.0 s   1 tool
```

The distribution is bimodal. Short turns (a few seconds) are cache hits where
only the tool result was appended. Long turns are new-generation work, and one
of them, turn 4, is a single generation of 14142 tokens.

## Thinking time

Every turn logs a thinking block. Summed across the session:

```text
thinking turns  = 33
total thinking  = 2766 s (46.1 min)
median thinking = 29 s
max thinking    = 1336 s (turn 4)
```

Thinking is 87% of the 53.2 minutes of turn wall clock. Generation throughput,
not prefill, is what the agent actually spends its time on once the prefix is
warm.

## Tool usage

Counted from occurrences of `"name": "<tool>"` in the logged request bodies:

```text
bash     315
read     209
edit     138
write     61
ffgrep    33
fffind    33
```

`ffgrep` and `fffind` land on exactly 33, one per turn, which is the signature of
a schema block rather than a call: they appear once in each of the 33 tool-schema
payloads and were never actually invoked. `bash`, `read`, `edit` and `write` far
exceed 33 and are the real calls. Read the first four numbers as usage and the
last two as noise from the schema re-sent every request.

That re-send is also why the first prompt is 25741 tokens: the 35 tool schemas
are part of every request.

## Relation to the server log

```text
server: 33 tasks served, 55818 prompt tokens, 27643 generated tokens
client: 33 turns, first-token median 6.3s warm
```

The two line up one-to-one: 33 turns in the client, 33 tasks in llama.cpp. The
client-side wait is the server-side work plus the harness overhead of streaming
and re-serialising the transcript.

## What the trace shows that the server log does not

`llama.log` reports 9-12 tok/s per turn and looks steady; this trace shows what
that rate is felt as. The user-visible experience is a 4.5-minute cold start,
then a string of 5-30s waits, punctuated by one multi-minute turn. Aggregate
throughput hides that shape; the per-turn table is the number that describes how
the agent feels to use.

The two logs also disagree on emphasis. The server log's largest single task is
task 727 at 14142 generated tokens, which reads as one heavy generation. The
client trace shows that same generation as turn 4, a 1353s turn that is 87% of
the session's thinking time. Neither number is wrong; they measure different
sides of the same wait.
