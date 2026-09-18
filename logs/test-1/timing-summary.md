# Timing summary extracted from raw session

## Startup

```text
llama threadpool init, n_threads = 4
n_slots = 1
n_ctx_slot = 131072
kv_unified = true
model loaded
listening on http://0.0.0.0:1234
```

## Task 0 — cold agent prefix

```text
prompt eval time = 271407.57 ms / 26499 tokens
                 = 97.64 tokens/s

eval time        = 689.90 ms / 9 tokens
                 = 11.60 tokens/s

total time       = 272097.46 ms / 26508 tokens
```

## Task 65 — warm cached turn

```text
LCP similarity = 0.999
prompt eval = 930.00 ms / 16 tokens
eval        = 665.27 ms / 9 tokens = 12.03 tok/s
total       = 1595.27 ms
```

## Task 77 — warm cached turn

```text
LCP similarity = 0.999
prompt eval = 973.77 ms / 18 tokens
eval        = 2196.05 ms / 28 tokens = 12.29 tok/s
total       = 3169.82 ms
```

## Task 108 — tool-loop delta

```text
LCP similarity = 0.995
prompt eval = 1812.14 ms / 142 tokens = 78.36 tok/s
eval        = 4494.02 ms / 32 tokens = 6.90 tok/s
total       = 6306.17 ms

draft acceptance = 0.03125 (2 accepted / 64 generated)
```

## Task 140 — larger cached delta

```text
LCP similarity = 0.968
prompt eval = 7913.32 ms / 870 tokens = 109.94 tok/s
eval        = 16823.78 ms / 205 tokens = 12.13 tok/s
total       = 24737.09 ms
final slot tokens = 27823
```
