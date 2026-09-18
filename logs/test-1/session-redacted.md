**user@llm-server**

:

**\~**

$ $HOME/.unsloth/llama.cpp/build/bin/llama-server   -m "$HOME/.cache/huggingface/hub/models--AtomicChat--Qwen3.8-Flash-Next-GGUF/snapshots/142262902a46f7daed19c79d0771534c8106ad59/Qwen3.8-Flash-Next-AD-3.84bpw-IQ4\_XS-M64/Qwen3.8-Flash-Next-AD-3.84bpw-IQ4\_XS-M64-00001-of-00028.gguf"   --alias qwen3.8-flash-next   --jinja   -ngl 99   --fit on   -fa on   -c 131072   -ctk q4\_0   -ctv q4\_0   -b 512   -ub 256   -t 6   -tb 6   --no-warmup   --spec-type ngram-mod   --host 0.0.0.0   --port 1234   -ts 3.5,1   --n-cpu-moe 32   --temp 1   --top-k 20   --min-p 0   --top-p 0.95   --load-mode none   --lazy-mode on   -sm layer --parallel 1 --kv-unified  --threads 4 --threads-batch 4 --no-context-shift --metrics --jinja 

0.00.772.929

W DEPRECATED: argument '--jinja' specified multiple times, use comma-separated values instead (only last value will be used)

0.00.773.211

I 

cmn  common\_param: common\_params\_print\_info: verbosity = 3 (adjust with the \`-lv N\` CLI arg) 

0.00.774.840

W srv  llama\_server: -----------------

0.00.774.845

W srv  llama\_server: CORS is set to allow all origins ('\*') and no API key is set

0.00.774.846

W srv  llama\_server: this can be a security risk (cross-origin attacks)

0.00.774.847

W srv  llama\_server: more info: https\://github.com/ggml-org/llama.cpp/pull/25655

0.00.774.848

W srv  llama\_server: -----------------

0.00.776.776

I 

srv    load\_model: loading model '$HOME/.cache/huggingface/hub/models--AtomicChat--Qwen3.8-Flash-Next-GGUF/snapshots/142262902a46f7daed19c79d0771534c8106ad59/Qwen3.8-Flash-Next-AD-3.84bpw-IQ4\_XS-M64/Qwen3.8-Flash-Next-AD-3.84bpw-IQ4\_XS-M64-00001-of-00028.gguf' 

0.40.471.080

I 

cmn          init: llama threadpool init, n\_threads = 4 

0.40.801.164

I 

srv    load\_model: initializing, n\_slots = 1, n\_ctx\_slot = 131072, kv\_unified = 'true' 

0.40.821.718

W srv          init: chat template supports preserving reasoning, it is enabled by default (may use more tokens, disable via --no-reasoning-preserve)

0.40.822.114

I 

srv  llama\_server: model loaded 

0.40.822.119

I 

srv  llama\_server: listening on http\://0.0.0.0:1234 

0.44.110.235

I 

slot get\_availabl: id  0 | task -1 | selected slot by LRU, t\_last = -1 

0.44.112.059

I 

slot launch\_slot\_: id  0 | task 0 | processing task, is\_child = 0 

0.49.992.163

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =    512, progress = 0.02, t =   5.88 s / 87.07 tokens per second 

0.55.157.376

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   1024, progress = 0.04, t =  11.05 s / 92.71 tokens per second 

0.59.787.205

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   1536, progress = 0.06, t =  15.68 s / 97.99 tokens per second 

1.04.777.809

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   2048, progress = 0.08, t =  20.67 s / 99.10 tokens per second 

1.09.822.589

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   2560, progress = 0.10, t =  25.71 s / 99.57 tokens per second 

1.14.850.878

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   3072, progress = 0.12, t =  30.74 s / 99.94 tokens per second 

1.20.128.719

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   3584, progress = 0.14, t =  36.02 s / 99.51 tokens per second 

1.25.408.568

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   4096, progress = 0.15, t =  41.30 s / 99.19 tokens per second 

1.30.390.984

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   4608, progress = 0.17, t =  46.28 s / 99.57 tokens per second 

1.35.901.333

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   5120, progress = 0.19, t =  51.79 s / 98.86 tokens per second 

1.41.246.851

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   5632, progress = 0.21, t =  57.13 s / 98.57 tokens per second 

1.46.512.808

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   6144, progress = 0.23, t =  62.40 s / 98.46 tokens per second 

1.52.198.899

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   6656, progress = 0.25, t =  68.09 s / 97.76 tokens per second 

1.57.723.810

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   7168, progress = 0.27, t =  73.61 s / 97.38 tokens per second 

2.03.264.168

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   7680, progress = 0.29, t =  79.15 s / 97.03 tokens per second 

2.08.838.844

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   8192, progress = 0.31, t =  84.73 s / 96.69 tokens per second 

2.14.316.844

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   8704, progress = 0.33, t =  90.20 s / 96.49 tokens per second 

2.19.783.625

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   9216, progress = 0.35, t =  95.67 s / 96.33 tokens per second 

2.25.430.013

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =   9728, progress = 0.37, t = 101.32 s / 96.01 tokens per second 

2.30.882.413

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  10240, progress = 0.39, t = 106.77 s / 95.91 tokens per second 

2.36.539.220

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  10752, progress = 0.41, t = 112.43 s / 95.64 tokens per second 

2.42.129.552

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  11264, progress = 0.43, t = 118.02 s / 95.44 tokens per second 

2.47.617.775

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  11776, progress = 0.44, t = 123.51 s / 95.35 tokens per second 

2.52.796.525

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  12288, progress = 0.46, t = 128.68 s / 95.49 tokens per second 

2.57.903.459

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  12800, progress = 0.48, t = 133.79 s / 95.67 tokens per second 

3.03.137.469

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  13312, progress = 0.50, t = 139.03 s / 95.75 tokens per second 

3.08.026.851

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  13824, progress = 0.52, t = 143.91 s / 96.06 tokens per second 

3.13.370.123

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  14336, progress = 0.54, t = 149.26 s / 96.05 tokens per second 

3.18.732.664

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  14848, progress = 0.56, t = 154.62 s / 96.03 tokens per second 

3.24.042.918

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  15360, progress = 0.58, t = 159.93 s / 96.04 tokens per second 

3.29.474.512

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  15872, progress = 0.60, t = 165.36 s / 95.98 tokens per second 

3.34.795.218

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  16384, progress = 0.62, t = 170.68 s / 95.99 tokens per second 

3.40.432.306

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  16896, progress = 0.64, t = 176.32 s / 95.83 tokens per second 

3.45.037.821

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  17408, progress = 0.66, t = 180.93 s / 96.22 tokens per second 

3.49.379.609

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  17920, progress = 0.68, t = 185.27 s / 96.73 tokens per second 

3.53.935.828

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  18432, progress = 0.70, t = 189.82 s / 97.10 tokens per second 

3.58.282.529

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  18944, progress = 0.71, t = 194.17 s / 97.56 tokens per second 

4.03.258.561

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  19456, progress = 0.73, t = 199.15 s / 97.70 tokens per second 

4.08.447.461

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  19968, progress = 0.75, t = 204.34 s / 97.72 tokens per second 

4.13.579.804

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  20480, progress = 0.77, t = 209.47 s / 97.77 tokens per second 

4.18.848.149

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  20992, progress = 0.79, t = 214.74 s / 97.76 tokens per second 

4.23.967.246

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  21504, progress = 0.81, t = 219.86 s / 97.81 tokens per second 

4.29.174.129

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  22016, progress = 0.83, t = 225.06 s / 97.82 tokens per second 

4.34.435.234

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  22528, progress = 0.85, t = 230.32 s / 97.81 tokens per second 

4.39.704.482

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  23040, progress = 0.87, t = 235.59 s / 97.80 tokens per second 

4.44.914.406

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  23552, progress = 0.89, t = 240.80 s / 97.81 tokens per second 

4.49.974.158

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  24064, progress = 0.91, t = 245.86 s / 97.88 tokens per second 

4.55.177.027

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  24576, progress = 0.93, t = 251.06 s / 97.89 tokens per second 

5.00.470.909

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  25088, progress = 0.95, t = 256.36 s / 97.86 tokens per second 

5.05.684.107

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  25600, progress = 0.97, t = 261.57 s / 97.87 tokens per second 

5.10.354.148

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  26112, progress = 0.99, t = 266.24 s / 98.08 tokens per second 

5.12.068.577

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  26239, progress = 0.99, t = 267.96 s / 97.92 tokens per second 

5.14.406.149

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  26478, progress = 1.00, t = 270.29 s / 97.96 tokens per second 

5.14.781.595

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  26485, progress = 1.00, t = 270.67 s / 97.85 tokens per second 

5.15.230.484

I 

slot print\_timing: id  0 | task 0 | prompt processing, n\_tokens =  26495, progress = 1.00, t = 271.12 s / 97.72 tokens per second 

5.16.209.557

I 

slot print\_timing: id  0 | task 0 | prompt eval time =  271407.57 ms / 26499 tokens (   10.24 ms per token,    97.64 tokens per second) 

5.16.209.560

I 

slot print\_timing: id  0 | task 0 |        eval time =     689.90 ms /     9 tokens (   86.24 ms per token,    11.60 tokens per second) 

5.16.209.561

I 

slot print\_timing: id  0 | task 0 |       total time =  272097.46 ms / 26508 tokens 

5.16.209.564

I 

slot print\_timing: id  0 | task 0 |    graphs reused =          7 

5.16.210.868

I 

slot      release: id  0 | task 0 | stop processing: n\_tokens = 26507, truncated = 0 

6.11.543.523

I 

slot get\_availabl: id  0 | task -1 | selected slot by LCP similarity, f\_sim\_best = 0.999 (> 0.100 thold), f\_keep = 1.000 

6.11.544.296

I 

slot launch\_slot\_: id  0 | task 65 | processing task, is\_child = 0 

6.13.139.587

I 

slot print\_timing: id  0 | task 65 | prompt eval time =     930.00 ms /    16 tokens (   58.13 ms per token,    17.20 tokens per second) 

6.13.139.590

I 

slot print\_timing: id  0 | task 65 |        eval time =     665.27 ms /     9 tokens (   83.16 ms per token,    12.03 tokens per second) 

6.13.139.591

I 

slot print\_timing: id  0 | task 65 |       total time =    1595.27 ms /    25 tokens 

6.13.139.592

I 

slot print\_timing: id  0 | task 65 |    graphs reused =         14 

6.13.140.588

I 

slot      release: id  0 | task 65 | stop processing: n\_tokens = 26531, truncated = 0 

6.20.793.937

I 

slot get\_availabl: id  0 | task -1 | selected slot by LCP similarity, f\_sim\_best = 0.999 (> 0.100 thold), f\_keep = 1.000 

6.20.794.685

I 

slot launch\_slot\_: id  0 | task 77 | processing task, is\_child = 0 

6.23.964.522

I 

slot print\_timing: id  0 | task 77 | prompt eval time =     973.77 ms /    18 tokens (   54.10 ms per token,    18.48 tokens per second) 

6.23.964.525

I 

slot print\_timing: id  0 | task 77 |        eval time =    2196.05 ms /    28 tokens (   81.34 ms per token,    12.29 tokens per second) 

6.23.964.525

I 

slot print\_timing: id  0 | task 77 |       total time =    3169.82 ms /    46 tokens 

6.23.964.526

I 

slot print\_timing: id  0 | task 77 |    graphs reused =         40 

6.23.965.523

I 

slot      release: id  0 | task 77 | stop processing: n\_tokens = 26576, truncated = 0 

6.24.244.013

I 

slot get\_availabl: id  0 | task -1 | selected slot by LCP similarity, f\_sim\_best = 0.995 (> 0.100 thold), f\_keep = 1.000 

6.24.244.756

I 

slot launch\_slot\_: id  0 | task 108 | processing task, is\_child = 0 

6.30.550.945

I 

slot print\_timing: id  0 | task 108 | prompt eval time =    1812.14 ms /   142 tokens (   12.76 ms per token,    78.36 tokens per second) 

6.30.550.947

I 

slot print\_timing: id  0 | task 108 |        eval time =    4494.02 ms /    32 tokens (  144.97 ms per token,     6.90 tokens per second) 

6.30.550.948

I 

slot print\_timing: id  0 | task 108 |       total time =    6306.17 ms /   174 tokens 

6.30.550.949

I 

slot print\_timing: id  0 | task 108 |    graphs reused =         65 

6.30.551.377

I 

slot print\_timing: id  0 | task 108 | draft acceptance = 0.03125 (    2 accepted /    64 generated), mean len =  3.00 

6.30.552.669

I 

slot      release: id  0 | task 108 | stop processing: n\_tokens = 26749, truncated = 0 

6.32.896.619

I 

slot get\_availabl: id  0 | task -1 | selected slot by LCP similarity, f\_sim\_best = 0.968 (> 0.100 thold), f\_keep = 1.000 

6.32.897.380

I 

slot launch\_slot\_: id  0 | task 140 | processing task, is\_child = 0 

6.37.090.769

I 

slot print\_timing: id  0 | task 140 | prompt processing, n\_tokens =    512, progress = 0.99, t =   4.19 s / 122.10 tokens per second 

6.38.416.667

I 

slot print\_timing: id  0 | task 140 | prompt processing, n\_tokens =    610, progress = 0.99, t =   5.52 s / 110.52 tokens per second 

6.40.525.434

I 

slot print\_timing: id  0 | task 140 | prompt processing, n\_tokens =    866, progress = 1.00, t =   7.63 s / 113.53 tokens per second 

6.49.043.370

I 

slot print\_timing: id  0 | task 140 | n\_gen =    100, tg =  12.03 t/s, tg\_3s =  12.15 t/s 

6.52.121.041

I 

slot print\_timing: id  0 | task 140 | n\_gen =    138, tg =  12.11 t/s, tg\_3s =  12.35 t/s 

6.55.127.100

I 

slot print\_timing: id  0 | task 140 | n\_gen =    175, tg =  12.15 t/s, tg\_3s =  12.31 t/s 

6.57.634.495

I 

slot print\_timing: id  0 | task 140 | prompt eval time =    7913.32 ms /   870 tokens (    9.10 ms per token,   109.94 tokens per second) 

6.57.634.499

I 

slot print\_timing: id  0 | task 140 |        eval time =   16823.78 ms /   205 tokens (   82.47 ms per token,    12.13 tokens per second) 

6.57.634.499

I 

slot print\_timing: id  0 | task 140 |       total time =   24737.09 ms /  1075 tokens 

6.57.634.500

I 

slot print\_timing: id  0 | task 140 |    graphs reused =        267 

6.57.636.221

I 

slot      release: id  0 | task 140 | stop processing: n\_tokens = 27823, truncated = 0