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

## Showcase page (one-shot)

`experiment.html` is a single-file 16:9 summary page of this experiment, generated
in one shot by the model itself through this llama.cpp instance. `experiment.png`
is a screenshot of it and is the README cover. Neither artifact was edited by
hand: the page is the raw model output and the screenshot is a straight capture.

The prompt it was generated from:

```text
Create a page in html that displays the current experiment we are doing.

We are running a 176B parameter model on 2x RTX 3060 12GB at around 15 tokens per second.
My specific use-case for this long running tasks, where quality matters way more than speed.

You may check the current repository to see the tests and results yourself.

I want the style to be clean, profissional and tech/AI stuff.

Use elegant and polished elements, nothing fantasy or exaggerated sci-fi visuals.
Something to showcase the surprisingly usable performance on consumer GPUs for the right jobs.

Use a 16x9 layout, including a hero section, metrics, observations, highlight section and a footer with "Local AI experiment • llama.cpp • Qwen-based setup"

This should look like a high-quality visual summary card / benchmark page, not like a generic blog article or documentation page.
```

### Where the page's numbers come from

The prompt stated **176B** parameters and **~15 tok/s**, and both appear in the
generated page. Neither is a measurement in this file:

- **Parameter count:** never measured for this run. `llama.cpp` does not report
  it, and this repo records only the quant name and the publisher's file sizes.
  176B is the requester's working figure for the model class.
- **~15 tok/s:** above every generation rate in the tables above. The warm
  cached turns read 12.03 and 12.29 tok/s, and the longest sustained generation
  in that session (205 tokens) read 12.13 tok/s. The second run in `logs/test-2/`
  peaks at 12.64 tok/s on a single turn, still short of 15.

The generated page handles this correctly on its own: it keeps both figures and
carries a footnote stating that `~15 tok/s` is the observational working rate
while the session log reads 12.03-12.29 tok/s on cached turns. Treat the tables
above as the measurement and the page as the narrative.
