# Qwen3.8-Flash-Next on 2× RTX 3060 12 GB with llama.cpp

Real-world agent benchmark of **AtomicChat/Qwen3.8-Flash-Next-GGUF**, specifically the **AD-3.84bpw-IQ4_XS-M64** quant, running on a small Ubuntu LLM server with **2× NVIDIA RTX 3060 12 GB**.

The goal was not maximum chat latency. The goal was to find out whether a very large MoE model could be useful as a **quality-first local agent / batch worker** on consumer GPUs, with most expert weights partially offloaded to system RAM.

## TL;DR

It works surprisingly well once the prompt cache is warm.

| Scenario | Prompt work | Prompt speed | Generation | Total |
|---|---:|---:|---:|---:|
| Cold agent start | 26,499 tokens | 97.64 tok/s | 9 tok @ 11.60 tok/s | 272.10 s |
| Warm cached turn | 16 new tokens | 17.20 tok/s* | 9 tok @ 12.03 tok/s | 1.60 s |
| Warm cached turn | 18 new tokens | 18.48 tok/s* | 28 tok @ 12.29 tok/s | 3.17 s |
| Tool-loop delta | 142 new tokens | 78.36 tok/s | 32 tok @ 6.90 tok/s | 6.31 s |
| Larger cached delta | 870 new tokens | 109.94 tok/s | 205 tok @ 12.13 tok/s | 24.74 s |

\* Tiny cached deltas are dominated by fixed overhead, so tok/s is not directly comparable to large-prefill throughput.

The headline result is not simply “12 tok/s”. It is this:

> **26.5k-token agent prompt: ~4m31s cold prefill → subsequent cached turns in ~1–3 seconds before longer generation/tool work.**

That makes the setup much more viable for persistent agents and long-running batch workflows than the cold-start number suggests.

## Hardware

- **GPU 0:** NVIDIA GeForce RTX 3060, 12 GB
- **GPU 1:** NVIDIA GeForce RTX 3060, 12 GB
- **Combined physical VRAM:** 24 GB
- **Host memory:** 64 GB class (llama.cpp reported ~63,048 MiB host allocation capacity in earlier tuning runs)
- **OS:** Ubuntu Server
- **Workload:** single-user local agent / batch processing

CPU model and motherboard/PCIe topology were not recorded for this run, so I am intentionally not guessing them here.

## Model

- Repository: https://huggingface.co/AtomicChat/Qwen3.8-Flash-Next-GGUF
- Quant: `Qwen3.8-Flash-Next-AD-3.84bpw-IQ4_XS-M64`
- Publisher-reported total file size: **84.9 GB**
- Publisher-reported in-memory portion: **45.8 GB**
- Publisher-reported SSD-pageable n-gram table: **39.1 GB**

AtomicChat explains that a large part of this architecture is a sparse n-gram lookup table rather than ordinary dense weights. Their GGUF layout isolates that table so it can remain mmap/page-cache backed instead of being permanently resident.

## llama.cpp layout used

The working run used:

- `-sm layer`
- `-ts 3.5,1`
- `--n-cpu-moe 32`
- `-ngl 99`
- `-c 131072`
- `-ctk q4_0 -ctv q4_0`
- `--parallel 1`
- `--kv-unified`
- Flash Attention enabled
- `ngram-mod` speculative decoding enabled

The asymmetric `-ts 3.5,1` is deliberate. With `--n-cpu-moe 32`, the early layers become much lighter on GPU because their MoE expert weights are on CPU. A nominally symmetric tensor split (`1,1`) produced a very asymmetric VRAM footprint, so the layer boundary had to be shifted manually.

## What did not work

With `-ts 1,1`, the model allocation was heavily skewed toward one GPU. In one tuning run, llama.cpp reported approximately:

```text
CUDA0 model:  2,058 MiB
CUDA1 model: 15,886 MiB  -> OOM on a 12 GB card
```

At `-ts 3,1`, the distribution improved substantially:

```text
CUDA0 model:  6,905 MiB
CUDA1 model: 11,040 MiB
```

`-ts 3.5,1` was the first split tested that successfully started with the full `131072` context configuration.

## Agent test

The client was **Pi**, with a real system prompt, tool schemas, and agent context. The first request contained **26,499 prompt tokens**.

Cold prefill:

```text
prompt eval time = 271407.57 ms / 26499 tokens
                 = 97.64 tokens/second

eval time        = 689.90 ms / 9 tokens
                 = 11.60 tokens/second

total time       = 272097.46 ms
```

After that, llama.cpp's LCP/prompt cache worked extremely well:

```text
selected slot by LCP similarity, f_sim_best = 0.999
prompt eval = 930 ms / 16 new tokens
eval        = 665 ms / 9 generated tokens
total       = 1.595 s
```

A second warm request:

```text
LCP similarity = 0.999
prompt eval = 973.77 ms / 18 new tokens
eval        = 2196.05 ms / 28 generated tokens
total       = 3.170 s
```

The cache remained useful through tool use. A later turn with a larger delta processed 870 new tokens at ~109.94 tok/s and generated 205 tokens at ~12.13 tok/s.

## Speculative decoding observation

One tool-loop request showed:

```text
draft acceptance = 0.03125
2 accepted / 64 generated
```

That is only **3.125% draft-token acceptance** for that request. `ngram-mod` may still help on repetitive code/text workloads, but this result is a good reason to benchmark it against a no-speculation baseline rather than assuming it is always beneficial.

## Why this setup is useful to me

This is not intended to beat small local models on latency. I have workloads where:

- quality matters more than responsiveness;
- jobs are naturally long-running or batched;
- the model reviews files and project artifacts;
- a few minutes of cold-start prefill is acceptable;
- prompt caching makes subsequent steps dramatically cheaper.

Smaller MoE models (for example ~30B A3B-class models) are much faster on this hardware, but have been materially weaker for these tasks. Dense ~27B models can also run locally, but generation throughput can be in the same general range while offering a much smaller model capacity.

For this use case, **a large sparse model at ~12 tok/s can be more attractive than a much smaller model at higher throughput**.

## References

- AtomicChat model card: https://huggingface.co/AtomicChat/Qwen3.8-Flash-Next-GGUF
- llama.cpp multi-GPU guide: https://github.com/ggml-org/llama.cpp/blob/master/docs/multi-gpu.md
- llama.cpp speculative decoding guide: https://github.com/ggml-org/llama.cpp/blob/master/docs/speculative.md

## Notes / caveats

This is a **single-machine field test**, not a controlled cross-hardware benchmark. Numbers depend on llama.cpp build, CPU/RAM bandwidth, PCIe topology, filesystem/page-cache behavior, prompt shape, cache state, sampling, and the exact GGUF layout. The raw log is included so others can inspect the actual timings.
