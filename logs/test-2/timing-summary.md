# Timing summary extracted from raw session

## Startup

```text
common_fit_params: failed to fit params to free device memory:
                    n_gpu_layers already set by user to 99, abort
llama threadpool init, n_threads = 6
n_slots = 4
n_ctx_slot = 131072
kv_unified = true
model loaded
listening on http://0.0.0.0:1234
```

Note the difference from the `--parallel 1` run: this server started with
`n_slots = 4` on the same `131072` slot context.

## Task 0: cold agent prefix

```text
prompt eval time =  269458.43 ms / 25741 tokens
                 = 95.53 tok/s

eval time        =   19341.48 ms / 209 tokens
                 = 10.75 tok/s

total time       =  288799.91 ms / 25950 tokens
graphs reused    = 178

draft acceptance = 0.17188 (22 accepted / 128 generated), mean len = 12.00
```

Live prompt progress held between 94.0 and 98.1 tok/s for the whole 25.7k-token
prefill. The prompt was served by slot 3; slots 0, 1 and 2 never received work.

## Per-request aggregate over 33 tasks

```text
total prompt tokens =  55818
total generated     =  27643
prompt throughput   = 87.09 tok/s (weighted)
generation          = 10.00 tok/s (weighted)

generation t/s: min 5.83 | p25 8.94 | median 9.40 | p75 10.09 | max 12.64
prompt     t/s: large prefills cluster at 95-106 tok/s
```

## Speculative decoding across the run

```text
tasks reporting draft acceptance = 26 / 33
weighted acceptance              = 1634 accepted / 7634 generated = 0.2140
per-task acceptance: min 0.0312 | median 0.1919 | max 0.5312 | mean 0.2159
```

The best and worst turns of the run bracket this hard:

```text
task 18318  acceptance = 0            (no line emitted, 19 prompt tokens)
task 19620  acceptance = 0.03125      6 accepted / 192 generated, mean len = 3.00
task 19364  acceptance = 0.53125     68 accepted / 128 generated, mean len = 35.00
task 14941  acceptance = 0.45139    260 accepted / 576 generated, mean len = 29.89
```

Turns with high acceptance generated at 11.1-12.6 tok/s; turns with acceptance
near 0.03 dropped to 9.2 tok/s.

## Longest generations

```text
task   727   prompt 1709 tok @ 103.39 t/s | gen 14142 tok @ 10.58 t/s | total 1352.5 s
task 21792   prompt  715 tok @  66.08 t/s | gen  1327 tok @  9.23 t/s | total  154.5 s
task 14941   prompt   73 tok @  48.54 t/s | gen  1271 tok @ 11.12 t/s | total  115.7 s
task 20481   prompt  524 tok @  66.54 t/s | gen  1178 tok @  9.40 t/s | total  133.1 s
task 25042   prompt  566 tok @  70.18 t/s | gen  1173 tok @  9.19 t/s | total  135.6 s
```

Task 727 alone is 14142 of the 27643 generated tokens, half the run's output in
a single agent turn.

## Slot context growth

```text
after task     0: n_tokens = 25949
after task   426: n_tokens = 30201
after task   727: n_tokens = 46051
after task 14788: n_tokens = 46243
after task 25042: n_tokens = 63280
```

Every release reports `truncated = 0`. The 131k slot never came close to the
limit, so no context shift ever fired.
