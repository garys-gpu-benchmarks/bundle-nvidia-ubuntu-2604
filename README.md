# NVIDIA CUDA - Ubuntu 26.04 benchmark bundle

32 system and GPU benchmarks for NVIDIA GPU machines running Ubuntu 26.04,
each pinned to its tested v1.0.22 release.

Use this bundle only on that platform. The others have their own bundle:
[AMD 24.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2404) ·
[NVIDIA 24.04](https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2404) ·
[AMD 26.04](https://github.com/garys-gpu-benchmarks/bundle-amd-ubuntu-2604) ·
[NVIDIA 26.04](https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604)

## Before you start

- A freshly installed **Ubuntu 26.04** machine with NVIDIA GPUs, connected to the internet.
- **root** access: log in as root, or run `sudo -i` first.
- Plenty of free disk space. Each benchmark installs its own software (its own
  Python environment) the first time it runs, and checks for at least 20 GiB
  free before it does. That check is per benchmark, not for the whole suite,
  and the AI benchmarks also download models.
- The NVIDIA driver already installed: `nvidia-smi` lists the GPUs. The first
  run installs CUDA; it does not install the driver or restart the machine.
- For the AI model benchmarks (423 to 432): if a model's license on Hugging
  Face requires it, accept the license there and set a token first:
  `export HF_TOKEN=hf_...`

## Install

```bash
apt-get update && apt-get install -y git tmux
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604 /opt/benchmarks
cd /opt/benchmarks
./run_benchmark_suite.sh --list
```

`./run_benchmark_suite.sh --list` should show all 32 benchmarks as `ready`.
Do not use GitHub's **Download ZIP**: it leaves the benchmark folders empty.

## Getting started

Each command below ends with a summary like the samples shown. Your times,
host name and log file name will differ; what matters is `0 failed`. If a run
fails, the summary names it under `Failed runs:`; open the log file named on
the summary's last line.

### 1. A CPU benchmark (about a minute, no GPU software)

```bash
cd /opt/benchmarks
./run_benchmark_suite.sh -w 407 --smoke --show-output
```

407 is STREAM, CPU memory bandwidth. It installs only a compiler and its own
Python environment, not CUDA, and does not restart the machine. It ends
with Copy, Scale, Add and Triad rates in GB/s. Smoke uses 4 threads; the
`baseline` profile is the figure to quote for this machine. If this run
passes, the bundle, the suite runner, the results and the runtime ledger all
work. It ends like this:

```text
======================================================================
SUMMARY: 1 of 1 runs finished: 1 passed, 0 failed
Started:       Mon Oct 19 22:03:51 UTC 2026
Completed:     Mon Oct 19 22:04:35 UTC 2026
Total runtime: 0 hours 0 minutes 44 seconds
Log file:      /opt/benchmarks/benchmark_suite_log/run_benchmark_suite_<host>_20261019_220351.log
======================================================================
```

To see that run in the runtime ledger: `./show_metrics.sh 407`

### 2. The GPU software and two quick GPU checks (5 to 20 minutes the first time)

The first time, 401 installs CUDA, which takes 5 to 20 minutes. Run it
either way:

```bash
./run_benchmark_suite.sh -w 401,402,414 --smoke --show-output   # shows progress while CUDA installs
./run_benchmark_suite.sh -w 401,402,414 --smoke                 # quiet: prints nothing for 5 to 20 minutes
```

In quiet mode, watch progress from a second window with
`tail -f /opt/benchmarks/401-*/results/install_status.txt`.

| Benchmark | What it checks |
|---|---|
| 401 | installs CUDA, then checks the installed GPU software (the long step) |
| 402 | GPU health: the GPUs are visible, with temperature and link status |
| 414 | copy bandwidth between the host and the GPU, measured at 256 MiB |

401 installs CUDA only. It does not install the NVIDIA driver and does not
restart the machine.

When all three pass, it ends like this:

```text
======================================================================
SUMMARY: 3 of 3 runs finished: 3 passed, 0 failed
Started:       Mon Oct 19 22:07:13 UTC 2026
Completed:     Mon Oct 19 22:13:14 UTC 2026
Total runtime: 0 hours 6 minutes 1 seconds
Log file:      /opt/benchmarks/benchmark_suite_log/run_benchmark_suite_<host>_20261019_220713.log
======================================================================
```

### 3. Smoke is a wiring check, not a measurement

Smoke shows that each benchmark installs, runs and records its results. Most
smoke runs use small sizes, so their numbers are not for reports: for example,
420 (HPL FP64) smoke solves a 4096 x 4096 system, too small to load the GPU,
and 415 (GPU memory bandwidth) smoke runs only 20 iterations. Quote
`baseline` or `extended` results. Smoke is short for most
benchmarks, but the AI benchmarks (423 to 432) download models the first
time, so their first smoke run takes longer.

### 4. Run one benchmark

Each benchmark installs its own software the first time it runs, so a first
run takes longer than later ones. Each run prints a short block, and the suite
ends with the summary shown above. The full output is in
`/opt/benchmarks/benchmark_suite_log/`. To run a single benchmark with its
output on screen:

```bash
./run_benchmark_suite.sh -w 405 --smoke --show-output      # benchmark 405, smoke profile
./run_benchmark_suite.sh -w 405 --baseline --show-output   # the standard profile
```

## See your results

`show_metrics.sh` prints one benchmark's runs from the runtime ledger: one row
per run with its metrics, then the mean for each profile.

```bash
cd /opt/benchmarks
./show_metrics.sh 407                # benchmark 407, every profile
./show_metrics.sh 407 --baseline     # baseline runs only
./show_metrics.sh --help             # all options
```

To copy the results to your laptop, see [Results](#results).

## Run everything

Run the full suite inside `tmux`, so it keeps running if your connection drops.
It takes many hours.

```bash
tmux new -s bench
cd /opt/benchmarks
./run_benchmark_suite.sh --smoke --baseline --extended
```

This runs all 32 benchmarks with the `smoke` profile, then all with
`baseline`, then all with `extended`. With no profile option,
`./run_benchmark_suite.sh` runs the `smoke` profile only. Detach with
**Ctrl+B** then **D**; reattach later with `tmux attach -t bench`.

Run "Getting started" first on a new machine, so the one-time install (and any
restart) happens before the long run.

| Option | What it does |
|---|---|
| `--baseline` | profile to run: `--smoke`, `--baseline` or `--extended`; give more than one to run them in that order. Default: `--smoke` |
| `-w 401,407,421` | only these benchmarks; ranges work too: `-w 401-410` |
| `-r 20` | repeat the whole set 20 times (soak test) |
| `--fail-fast` | stop at the first failed run |
| `--show-output` | show each run's full output on screen too (it always goes to the log) |
| `--list` | list the benchmarks as `ready` or `not fetched`, then exit |
| `-n` | show what would run, without running it |
| `--help` | all options |

## Results that are expected to be `na`

A metric written as `na (reason)` was not measured on this machine; it is
never an invented number. Read the reason before reporting a fault. These are
expected:

| Benchmark | Expected result |
|---|---|
| 416 | On a machine with one GPU, the bandwidth metrics are `na (requires at least two GPUs)` and the run still passes. |
| 411 | Hardware counters are `na` with the reason when `perf` is not installed for the running kernel, or when `perf_event_paranoid` denies access. |
| 406 | Measures a file (`data/fio_target.bin`) on the disk that holds the benchmark, not a raw NVMe device. |
| 408 | Measures the loopback path (`127.0.0.1`), not a network card. |
| 430, 431 | The `smoke` profile may use a stand-in server; only `baseline` and `extended` measure SGLang. |

## Results

| What | Where |
|---|---|
| Summary of the suite | end of the screen output |
| Full output of every run | `/opt/benchmarks/benchmark_suite_log/` |
| Each benchmark's results | `/opt/benchmarks/<benchmark>/results/` (`raw/` and `parsed/`) |
| One line per run (time, exit code) | `/var/opt/benchmarks/runtime_ledger.csv` |
| One benchmark's runs and per-profile means | `./show_metrics.sh <benchmark>` |
| Which release is installed | `git -C /opt/benchmarks describe --tags` |

To copy the ledger, every benchmark's `results/` and the suite logs to your
laptop (Git Bash on Windows), use `get_remote_info.sh` from
[gpu-bench-suite](https://github.com/garys-gpu-benchmarks/gpu-bench-suite). It writes
`RUNTIME_LEDGERS/` and `DIRECTORIES/` in the folder you run it from:

```bash
git clone https://github.com/garys-gpu-benchmarks/gpu-bench-suite && cd gpu-bench-suite
./scripts/get_remote_info.sh --host 203.0.113.10       # this machine's address; --port PORT if ssh is not on 22
./scripts/show_metrics.sh 407 --host 203.0.113.10      # the same table, read over ssh
```

## Update to a newer release

```bash
cd /opt/benchmarks
git pull && git submodule update --init --recursive
```

Do not use `git submodule update --remote`: it moves the benchmarks off the
release they were tested at.

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

