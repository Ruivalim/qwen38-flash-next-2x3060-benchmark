# Results

## Recorded server configuration

The raw log shows a single slot with a 131,072-token slot context and unified KV cache:

```text
n_slots = 1
n_ctx_slot = 131072
kv_unified = true
```

The model loaded and the HTTP server listened on `0.0.0.0:1234`.

## Cold request

| Metric | Result |
|---|---:|
| Prompt tokens | 26,499 |
| Prompt eval time | 271.408 s |
| Prompt throughput | 97.64 tok/s |
| Generated tokens | 9 |
| Generation throughput | 11.60 tok/s |
| Total request time | 272.097 s |
| Truncated | No |

This is the cost of ingesting the full Pi agent prefix (system prompt, tools, and surrounding context) from a cold slot.

## Warm request 1

LCP similarity: `0.999`.

| Metric | Result |
|---|---:|
| New prompt tokens | 16 |
| Prompt eval | 0.930 s |
| Generated tokens | 9 |
| Generation throughput | 12.03 tok/s |
| Total | 1.595 s |

## Warm request 2

LCP similarity: `0.999`.

| Metric | Result |
|---|---:|
| New prompt tokens | 18 |
| Prompt eval | 0.974 s |
| Generated tokens | 28 |
| Generation throughput | 12.29 tok/s |
| Total | 3.170 s |

## Tool-loop request

LCP similarity: `0.995`.

| Metric | Result |
|---|---:|
| New prompt tokens | 142 |
| Prompt throughput | 78.36 tok/s |
| Generated tokens | 32 |
| Generation throughput | 6.90 tok/s |
| Total | 6.306 s |
| ngram-mod acceptance | 2 / 64 = 3.125% |

The low generation rate on this turn coincided with very poor speculative-draft acceptance. This is correlation from one turn, not proof of causation; an A/B run without speculative decoding is needed.

## Larger cached delta

LCP similarity: `0.968`.

| Metric | Result |
|---|---:|
| New prompt tokens | 870 |
| Prompt eval time | 7.913 s |
| Prompt throughput | 109.94 tok/s |
| Generated tokens | 205 |
| Generation throughput | 12.13 tok/s |
| Total | 24.737 s |
| Final slot token count | 27,823 |

During generation the live timing reports were stable around 12.0–12.2 tok/s.

## Interpretation

The limiting UX factor is **cold prefill**, not steady-state generation. Once llama.cpp can reuse the long prefix, the agent becomes responsive enough for tool loops and incremental work.

For persistent quality-first jobs, that changes the economics of the setup: paying a multi-minute initialization cost can be acceptable if the same slot stays hot for a long batch.
