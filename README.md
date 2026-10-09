# NVIDIA CUDA - Ubuntu 26.04 benchmark bundle

All 32 benchmarks for this platform, each pinned to its tested v1.0.6 commit as a git submodule.
Project home: https://github.com/garymichaelbass

## Install

On a fresh Ubuntu machine, this downloads all 32 benchmarks into /opt/benchmarks:

```bash
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604 /opt/benchmarks
```

As a normal user (not root), first install git and create the folder:

```bash
sudo apt-get update && sudo apt-get install -y git
sudo mkdir -p /opt/benchmarks && sudo chown "$USER":"$USER" /opt/benchmarks
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604 /opt/benchmarks
```

Each benchmark is then in its own folder, for example /opt/benchmarks/401-…, next to run.sh and run_benchmark_suite.sh. Check with:

```bash
cd /opt/benchmarks && ./run.sh list
```

`./run.sh list` should show all 32 benchmarks as `ready`. To download only the benchmarks you run, leave out `--recurse-submodules`: `./run.sh` then fetches each benchmark the first time it is used.

Do not use Download ZIP: GitHub's ZIP files leave the benchmark folders empty.

## Run

```bash
cd /opt/benchmarks
./run.sh 405                 # setup, then a smoke run of benchmark 405
./run.sh 405 --baseline      # standard run
./run.sh all                 # all 32, logs in results/
```

The first benchmark's setup may install the GPU software stack, ask for your sudo password, and need a reboot. Read each benchmark's README.md before running it.

## Run the whole suite

`run_benchmark_suite.sh` runs every installed benchmark with each profile (smoke, then baseline, then extended), prints one short block per run, keeps the full output in a log file, and ends with a pass/fail summary.

```bash
cd /opt/benchmarks
./run_benchmark_suite.sh                         # all 32 benchmarks, smoke + baseline + extended
./run_benchmark_suite.sh -p smoke                # quick check of everything
./run_benchmark_suite.sh -w 401,407,421 -p baseline  # chosen benchmarks only
./run_benchmark_suite.sh -r 20                   # repeat the whole set 20 times
./run_benchmark_suite.sh --help                  # all options
```

## Update

```bash
cd /opt/benchmarks
git pull && git submodule update --init --recursive
```

If your copy keeps its benchmarks in a benchmarks/ subfolder (bundles published before v1.0.5), delete it and clone again instead, as shown under Install.

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

