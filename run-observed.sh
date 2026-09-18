#!/usr/bin/env bash
set -euo pipefail

# Sanitized form of the command that produced the recorded benchmark.
# Set MODEL_PATH to shard 1 of the AtomicChat AD-3.84bpw-IQ4_XS-M64 GGUF.
MODEL_PATH="${MODEL_PATH:-/path/to/Qwen3.8-Flash-Next-AD-3.84bpw-IQ4_XS-M64-00001-of-00028.gguf}"
LLAMA_SERVER="${LLAMA_SERVER:-llama-server}"

exec "$LLAMA_SERVER" \
  -m "$MODEL_PATH" \
  --alias qwen3.8-flash-next \
  --jinja \
  -ngl 99 \
  --fit on \
  -fa on \
  -c 131072 \
  -ctk q4_0 \
  -ctv q4_0 \
  -b 512 \
  -ub 256 \
  --threads 4 \
  --threads-batch 4 \
  --no-warmup \
  --spec-type ngram-mod \
  --host 0.0.0.0 \
  --port 1234 \
  -ts 3.5,1 \
  --n-cpu-moe 32 \
  --temp 1 \
  --top-k 20 \
  --min-p 0 \
  --top-p 0.95 \
  --load-mode none \
  --lazy-mode on \
  -sm layer \
  --parallel 1 \
  --kv-unified \
  --no-context-shift \
  --metrics
