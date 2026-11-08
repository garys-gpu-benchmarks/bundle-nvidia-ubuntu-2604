# NVIDIA CUDA - Ubuntu 26.04 benchmark bundle

32 system and GPU benchmarks for NVIDIA GPU machines running Ubuntu 26.04,
each pinned to its tested v1.0.31 release. Other platforms have their own bundle:
[AMD 24.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2404) ·
[NVIDIA 24.04](https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2404) ·
[AMD 26.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2604)

## Requirements

- A fresh **Ubuntu 26.04** machine with NVIDIA GPUs, online, with **root** access (`sudo -i`).
- The NVIDIA driver installed: `nvidia-smi` lists the GPUs. The first run installs CUDA;
  it never installs the driver or restarts the machine.
- At least 20 GiB free per benchmark: each one installs its own Python environment on
  first run, and the AI benchmarks also download models.
- For 423 to 432: if a model's Hugging Face license requires it, accept it there and
  `export HF_TOKEN=hf_...`

## Install

```bash
apt-get update && apt-get install -y git tmux
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604 /opt/benchmarks
cd /opt/benchmarks
./run_benchmark_suite.sh --list      # all 32 should show as ready
```

Clone with git; GitHub's **Download ZIP** leaves the benchmark folders empty.

## Quick check

```bash
./run_benchmark_suite.sh -w 407 --smoke --show-output            # CPU only, about a minute
./run_benchmark_suite.sh -w 401,402,414 --smoke --show-output    # installs CUDA first: 5 to 20 minutes
```

Each run ends with a summary. What matters is `0 failed`; if a run fails, it is listed
under `Failed runs:` and the log file is named on the summary's last line.

Smoke runs are small and only prove each benchmark installs, runs and records results.
Quote `baseline` or `extended` numbers.

## Run benchmarks

```bash
./run_benchmark_suite.sh -w 405 --baseline --show-output   # one benchmark
```

For the full suite (many hours), run the Quick check first on a new machine, then use
`tmux` so it survives a dropped connection (detach **Ctrl+B D**, reattach
`tmux attach -t bench`):

```bash
tmux new -s bench
cd /opt/benchmarks && ./run_benchmark_suite.sh --smoke --baseline --extended
```

| Option | Effect |
|---|---|
| `--smoke` `--baseline` `--extended` | Profiles to run, in that order. Default: `--smoke` |
| `-w 401,407` or `-w 401-410` | Only these benchmarks |
| `-r 20` | Repeat the whole set 20 times |
| `--fail-fast` | Stop at the first failure |
| `--show-output` | Show each run's output on screen (always written to the log) |
| `-n` | Show what would run, without running it |
| `--help` | All options |

## Results

```bash
./show_metrics.sh 407 [--baseline]     # one benchmark's runs and per-profile means
./list_runs.sh [--failed]                # every run on this machine
./get_benchmark_results.sh -o ~/results   # copy ledger, results and logs into one folder
```

| What | Where |
|---|---|
| Suite logs | `/opt/benchmarks/benchmark_suite_log/` |
| Per-benchmark results | `/opt/benchmarks/<benchmark>/results/` |
| Runtime ledger (one line per run) | `/var/opt/benchmarks/runtime_ledger.csv` |
| Installed release | `git -C /opt/benchmarks describe --tags` |

To pull results to your laptop (Git Bash on Windows works), clone
[gpu-bench-suite](https://github.com/garys-gpu-benchmarks/gpu-bench-suite) and run
`./get_benchmark_results.sh --host <address>` (add `--port N` if ssh is not on 22).
`list_runs.sh` and `show_metrics.sh` there accept `--host` too.

## Reading the results

A value of `na (reason)` means not measured on this machine, never an invented number.

| Benchmark | Note |
|---|---|
| 416 | One GPU: bandwidth metrics are `na (requires at least two GPUs)`; the run still passes. |
| 411 | Hardware counters are `na` when `perf` is missing for the running kernel or `perf_event_paranoid` denies access. |
| 406 | Measures a file (`data/fio_target.bin`) on the benchmark's disk, not a raw NVMe device. |
| 408 | Measures loopback (`127.0.0.1`), not a network card. |
| 430, 431 | Every profile, smoke included, starts the real SGLang server: allow about 2 minutes for it to start, and longer on the first run, which downloads the Mistral weights. |

## Update

```bash
cd /opt/benchmarks && git pull && git submodule update --init --recursive
```

Do not use `git submodule update --remote`; it moves benchmarks off their tested release.

## Benchmarks

| # | Repository |
|---|---|
| 401 | [cuda-stack-validation](https://github.com/garys-gpu-benchmarks/401-sys-bench-nvidia-cuda-stack-validation-ubu2604) |
| 402 | [gpu-health-validation](https://github.com/garys-gpu-benchmarks/402-sys-bench-nvidia-gpu-health-validation-ubu2604) |
| 403 | [system-stress-stability](https://github.com/garys-gpu-benchmarks/403-sys-bench-nvidia-system-stress-stability-ubu2604) |
| 404 | [sdc-ecc-integrity](https://github.com/garys-gpu-benchmarks/404-gpu-bench-nvidia-sdc-ecc-integrity-ubu2604) |
| 405 | [pytorch-tensor-correctness](https://github.com/garys-gpu-benchmarks/405-gpu-bench-nvidia-pytorch-tensor-correctness-ubu2604) |
| 406 | [fio-nvme-sweep](https://github.com/garys-gpu-benchmarks/406-sys-bench-nvidia-fio-nvme-sweep-ubu2604) |
| 407 | [stream-ddr5-bandwidth](https://github.com/garys-gpu-benchmarks/407-sys-bench-nvidia-stream-ddr5-bandwidth-ubu2604) |
| 408 | [iperf3-network-performance](https://github.com/garys-gpu-benchmarks/408-sys-bench-nvidia-iperf3-network-performance-ubu2604) |
| 409 | [multichase-numa-latency](https://github.com/garys-gpu-benchmarks/409-sys-bench-nvidia-multichase-numa-latency-ubu2604) |
| 410 | [numa-cache-performance](https://github.com/garys-gpu-benchmarks/410-sys-bench-nvidia-numa-cache-performance-ubu2604) |
| 411 | [linux-perf-pmu](https://github.com/garys-gpu-benchmarks/411-sys-bench-nvidia-linux-perf-pmu-ubu2604) |
| 412 | [lmbench-microbench-suite](https://github.com/garys-gpu-benchmarks/412-sys-bench-nvidia-lmbench-microbench-suite-ubu2604) |
| 413 | [gups-random-memory](https://github.com/garys-gpu-benchmarks/413-sys-bench-nvidia-gups-random-memory-ubu2604) |
| 414 | [memcpy-transfer-bandwidth](https://github.com/garys-gpu-benchmarks/414-gpu-bench-nvidia-memcpy-transfer-bandwidth-ubu2604) |
| 415 | [babelstream-hbm-bandwidth](https://github.com/garys-gpu-benchmarks/415-gpu-bench-nvidia-babelstream-hbm-bandwidth-ubu2604) |
| 416 | [nccl-bandwidth-test](https://github.com/garys-gpu-benchmarks/416-gpu-bench-nvidia-nccl-bandwidth-test-ubu2604) |
| 417 | [gemm-cublas-micro](https://github.com/garys-gpu-benchmarks/417-gpu-bench-nvidia-gemm-cublas-micro-ubu2604) |
| 418 | [cudnn-convolution-micro](https://github.com/garys-gpu-benchmarks/418-gpu-bench-nvidia-cudnn-convolution-micro-ubu2604) |
| 419 | [torch-micro-suite](https://github.com/garys-gpu-benchmarks/419-gpu-bench-nvidia-torch-micro-suite-ubu2604) |
| 420 | [linpack-hpl-fp64](https://github.com/garys-gpu-benchmarks/420-gpu-bench-nvidia-linpack-hpl-fp64-ubu2604) |
| 421 | [resnet50-pytorch-training](https://github.com/garys-gpu-benchmarks/421-gpu-bench-nvidia-resnet50-pytorch-training-ubu2604) |
| 422 | [resnet50-pytorch-inference](https://github.com/garys-gpu-benchmarks/422-gpu-bench-nvidia-resnet50-pytorch-inference-ubu2604) |
| 423 | [bert-base-inference](https://github.com/garys-gpu-benchmarks/423-gpu-bench-nvidia-bert-base-inference-ubu2604) |
| 424 | [sdxl-diffusers-latency](https://github.com/garys-gpu-benchmarks/424-gpu-bench-nvidia-sdxl-diffusers-latency-ubu2604) |
| 425 | [distilbert-hf-classification](https://github.com/garys-gpu-benchmarks/425-gpu-bench-nvidia-distilbert-hf-classification-ubu2604) |
| 426 | [jax-xla-forwardpass](https://github.com/garys-gpu-benchmarks/426-gpu-bench-nvidia-jax-xla-forwardpass-ubu2604) |
| 427 | [vllm-kvcache-stress](https://github.com/garys-gpu-benchmarks/427-gpu-bench-nvidia-vllm-kvcache-stress-ubu2604) |
| 428 | [vllm-throughput-latency](https://github.com/garys-gpu-benchmarks/428-gpu-bench-nvidia-vllm-throughput-latency-ubu2604) |
| 429 | [vllm-mistral-cuda](https://github.com/garys-gpu-benchmarks/429-gpu-bench-nvidia-vllm-mistral-cuda-ubu2604) |
| 430 | [sglang-prompt-response](https://github.com/garys-gpu-benchmarks/430-gpu-bench-nvidia-sglang-prompt-response-ubu2604) |
| 431 | [sglang-serving-latency](https://github.com/garys-gpu-benchmarks/431-gpu-bench-nvidia-sglang-serving-latency-ubu2604) |
| 432 | [rag-faiss-end2end](https://github.com/garys-gpu-benchmarks/432-gpu-bench-nvidia-rag-faiss-end2end-ubu2604) |
