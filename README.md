# NVIDIA CUDA - Ubuntu 26.04 benchmark bundle

32 system and GPU benchmarks for NVIDIA GPU machines running Ubuntu 26.04,
each pinned to its tested v1.0.8 release.

Use this bundle only on that platform. The others have their own bundle:
[AMD 24.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2404) ·
[NVIDIA 24.04](https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2404) ·
[AMD 26.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2604) ·
[NVIDIA 26.04](https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604)

## Before you start

- A freshly installed **Ubuntu 26.04** machine with NVIDIA GPUs, connected to the internet.
- **root** access: log in as root, or run `sudo -i` first.
- Plenty of free disk space. Each benchmark installs its own software the first
  time it runs, and checks for at least 20 GiB free before it does. The AI
  benchmarks also download models.
- For the AI model benchmarks (423 to 431): if a model's license on Hugging
  Face requires it, accept the license there and set a token first:
  `export HF_TOKEN=hf_...`

## Install

```bash
apt-get update && apt-get install -y git tmux
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604 /opt/benchmarks
cd /opt/benchmarks
./run.sh list
```

`./run.sh list` should show all 32 benchmarks as `ready`.
Do not use GitHub's **Download ZIP**: it leaves the benchmark folders empty.

## Getting started: three quick benchmarks

```bash
cd /opt/benchmarks
./run_benchmark_suite.sh -w 401,402,415 -p smoke
```

This runs the short `smoke` profile of three benchmarks:

| Benchmark | What it checks |
|---|---|
| 401 | the GPU software stack is installed and working |
| 402 | GPU health |
| 415 | GPU memory (HBM) bandwidth |

The first run takes much longer than later ones: it installs the NVIDIA driver and CUDA and each
benchmark's software. The install may restart the machine once. If it does,
log in again after the restart, wait a few minutes for setup to finish on its
own, and run the same command again.

Each run prints a short block, and the suite ends with a pass/fail summary.
The full output is in `/opt/benchmarks/benchmark_suite_log/`.

To run a single benchmark with its output on screen:

```bash
./run.sh 405                # setup, then the smoke profile of benchmark 405
./run.sh 405 --baseline     # the standard profile
```

## Run everything

Run the full suite inside `tmux`, so it keeps running if your connection drops.
It takes many hours.

```bash
tmux new -s bench
cd /opt/benchmarks
./run_benchmark_suite.sh
```

This runs all 32 benchmarks with the `smoke` profile, then all with
`baseline`, then all with `extended`. Detach with **Ctrl+B** then **D**;
reattach later with `tmux attach -t bench`.

Run "Getting started" first on a new machine, so the one-time install (and any
restart) happens before the long run.

| Option | What it does |
|---|---|
| `-p smoke` | profiles to run, in order (`smoke`, `baseline`, `extended`; comma-separated) |
| `-w 401,407,421` | only these benchmarks; ranges work too: `-w 401-410` |
| `-r 20` | repeat the whole set 20 times (soak test) |
| `--fail-fast` | stop at the first failed run |
| `-n` | show what would run, without running it |
| `--help` | all options |

## Results

| What | Where |
|---|---|
| Summary of the suite | end of the screen output |
| Full output of every run | `/opt/benchmarks/benchmark_suite_log/` |
| Each benchmark's results | `/opt/benchmarks/<benchmark>/results/` (`raw/` and `parsed/`) |
| One line per run (time, exit code) | `/var/opt/benchmarks/runtime_ledger.csv` |

To copy everything to a Windows laptop, use `get_remote_info.sh` from
[gpu-bench-suite](https://github.com/garys-gpu-benchmarks/gpu-bench-suite).

## Update to a newer release

```bash
cd /opt/benchmarks
git pull && git submodule update --init --recursive
```

Copies made before v1.0.5 keep their benchmarks in a `benchmarks/` subfolder;
delete those and clone again as shown under Install.

## Benchmarks

- **401** - [401-sys-bench-nvidia-cuda-stack-validation-ubu2604](https://github.com/garys-gpu-benchmarks/401-sys-bench-nvidia-cuda-stack-validation-ubu2604)
- **402** - [402-sys-bench-nvidia-gpu-health-validation-ubu2604](https://github.com/garys-gpu-benchmarks/402-sys-bench-nvidia-gpu-health-validation-ubu2604)
- **403** - [403-sys-bench-nvidia-system-stress-stability-ubu2604](https://github.com/garys-gpu-benchmarks/403-sys-bench-nvidia-system-stress-stability-ubu2604)
- **404** - [404-gpu-bench-nvidia-sdc-ecc-integrity-ubu2604](https://github.com/garys-gpu-benchmarks/404-gpu-bench-nvidia-sdc-ecc-integrity-ubu2604)
- **405** - [405-gpu-bench-nvidia-pytorch-tensor-correctness-ubu2604](https://github.com/garys-gpu-benchmarks/405-gpu-bench-nvidia-pytorch-tensor-correctness-ubu2604)
- **406** - [406-sys-bench-nvidia-fio-nvme-sweep-ubu2604](https://github.com/garys-gpu-benchmarks/406-sys-bench-nvidia-fio-nvme-sweep-ubu2604)
- **407** - [407-sys-bench-nvidia-stream-ddr5-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/407-sys-bench-nvidia-stream-ddr5-bandwidth-ubu2604)
- **408** - [408-sys-bench-nvidia-iperf3-network-performance-ubu2604](https://github.com/garys-gpu-benchmarks/408-sys-bench-nvidia-iperf3-network-performance-ubu2604)
- **409** - [409-sys-bench-nvidia-multichase-numa-latency-ubu2604](https://github.com/garys-gpu-benchmarks/409-sys-bench-nvidia-multichase-numa-latency-ubu2604)
- **410** - [410-sys-bench-nvidia-numa-cache-performance-ubu2604](https://github.com/garys-gpu-benchmarks/410-sys-bench-nvidia-numa-cache-performance-ubu2604)
- **411** - [411-sys-bench-nvidia-linux-perf-pmu-ubu2604](https://github.com/garys-gpu-benchmarks/411-sys-bench-nvidia-linux-perf-pmu-ubu2604)
- **412** - [412-sys-bench-nvidia-lmbench-microbench-suite-ubu2604](https://github.com/garys-gpu-benchmarks/412-sys-bench-nvidia-lmbench-microbench-suite-ubu2604)
- **413** - [413-sys-bench-nvidia-gups-random-memory-ubu2604](https://github.com/garys-gpu-benchmarks/413-sys-bench-nvidia-gups-random-memory-ubu2604)
- **414** - [414-gpu-bench-nvidia-memcpy-transfer-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/414-gpu-bench-nvidia-memcpy-transfer-bandwidth-ubu2604)
- **415** - [415-gpu-bench-nvidia-babelstream-hbm-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/415-gpu-bench-nvidia-babelstream-hbm-bandwidth-ubu2604)
- **416** - [416-gpu-bench-nvidia-nccl-bandwidth-test-ubu2604](https://github.com/garys-gpu-benchmarks/416-gpu-bench-nvidia-nccl-bandwidth-test-ubu2604)
- **417** - [417-gpu-bench-nvidia-gemm-cublas-micro-ubu2604](https://github.com/garys-gpu-benchmarks/417-gpu-bench-nvidia-gemm-cublas-micro-ubu2604)
- **418** - [418-gpu-bench-nvidia-cudnn-convolution-micro-ubu2604](https://github.com/garys-gpu-benchmarks/418-gpu-bench-nvidia-cudnn-convolution-micro-ubu2604)
- **419** - [419-gpu-bench-nvidia-torch-micro-suite-ubu2604](https://github.com/garys-gpu-benchmarks/419-gpu-bench-nvidia-torch-micro-suite-ubu2604)
- **420** - [420-gpu-bench-nvidia-linpack-hpl-fp64-ubu2604](https://github.com/garys-gpu-benchmarks/420-gpu-bench-nvidia-linpack-hpl-fp64-ubu2604)
- **421** - [421-gpu-bench-nvidia-resnet50-pytorch-training-ubu2604](https://github.com/garys-gpu-benchmarks/421-gpu-bench-nvidia-resnet50-pytorch-training-ubu2604)
- **422** - [422-gpu-bench-nvidia-resnet50-pytorch-inference-ubu2604](https://github.com/garys-gpu-benchmarks/422-gpu-bench-nvidia-resnet50-pytorch-inference-ubu2604)
- **423** - [423-gpu-bench-nvidia-bert-base-inference-ubu2604](https://github.com/garys-gpu-benchmarks/423-gpu-bench-nvidia-bert-base-inference-ubu2604)
- **424** - [424-gpu-bench-nvidia-sdxl-diffusers-latency-ubu2604](https://github.com/garys-gpu-benchmarks/424-gpu-bench-nvidia-sdxl-diffusers-latency-ubu2604)
- **425** - [425-gpu-bench-nvidia-distilbert-hf-classification-ubu2604](https://github.com/garys-gpu-benchmarks/425-gpu-bench-nvidia-distilbert-hf-classification-ubu2604)
- **426** - [426-gpu-bench-nvidia-jax-xla-forwardpass-ubu2604](https://github.com/garys-gpu-benchmarks/426-gpu-bench-nvidia-jax-xla-forwardpass-ubu2604)
- **427** - [427-gpu-bench-nvidia-vllm-kvcache-stress-ubu2604](https://github.com/garys-gpu-benchmarks/427-gpu-bench-nvidia-vllm-kvcache-stress-ubu2604)
- **428** - [428-gpu-bench-nvidia-vllm-throughput-latency-ubu2604](https://github.com/garys-gpu-benchmarks/428-gpu-bench-nvidia-vllm-throughput-latency-ubu2604)
- **429** - [429-gpu-bench-nvidia-vllm-mistral-cuda-ubu2604](https://github.com/garys-gpu-benchmarks/429-gpu-bench-nvidia-vllm-mistral-cuda-ubu2604)
- **430** - [430-gpu-bench-nvidia-sglang-prompt-response-ubu2604](https://github.com/garys-gpu-benchmarks/430-gpu-bench-nvidia-sglang-prompt-response-ubu2604)
- **431** - [431-gpu-bench-nvidia-sglang-serving-latency-ubu2604](https://github.com/garys-gpu-benchmarks/431-gpu-bench-nvidia-sglang-serving-latency-ubu2604)
- **432** - [432-gpu-bench-nvidia-rag-faiss-end2end-ubu2604](https://github.com/garys-gpu-benchmarks/432-gpu-bench-nvidia-rag-faiss-end2end-ubu2604)

