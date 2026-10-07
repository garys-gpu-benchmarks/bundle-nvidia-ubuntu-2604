# NVIDIA CUDA - Ubuntu 26.04 benchmark bundle

All 32 benchmarks for this platform, each pinned to its tested v1.0.3 commit as a git submodule.
Project home: https://github.com/garymichaelbass

```bash
git clone --recurse-submodules https://github.com/garys-gpu-benchmarks/bundle-nvidia-ubuntu-2604.git
cd bundle-nvidia-ubuntu-2604
./run.sh list                # the 32 benchmarks
./run.sh 405                 # smoke run of benchmark 405
./run.sh 405 --baseline      # standard run
./run.sh all                 # all 32, logs in results/
```

Clone without --recurse-submodules to download only what you run: ./run.sh fetches each benchmark on first use.

Do not use Download ZIP: GitHub's ZIP files leave the benchmarks/ folders empty.

## Benchmarks

- **401** - `benchmarks/nvidia-u26-401` - [401-sys-bench-nvidia-cuda-stack-validation-ubu2604](https://github.com/garys-gpu-benchmarks/401-sys-bench-nvidia-cuda-stack-validation-ubu2604)
- **402** - `benchmarks/nvidia-u26-402` - [402-sys-bench-nvidia-gpu-health-validation-ubu2604](https://github.com/garys-gpu-benchmarks/402-sys-bench-nvidia-gpu-health-validation-ubu2604)
- **403** - `benchmarks/nvidia-u26-403` - [403-sys-bench-nvidia-system-stress-stability-ubu2604](https://github.com/garys-gpu-benchmarks/403-sys-bench-nvidia-system-stress-stability-ubu2604)
- **404** - `benchmarks/nvidia-u26-404` - [404-gpu-bench-nvidia-sdc-ecc-integrity-ubu2604](https://github.com/garys-gpu-benchmarks/404-gpu-bench-nvidia-sdc-ecc-integrity-ubu2604)
- **405** - `benchmarks/nvidia-u26-405` - [405-gpu-bench-nvidia-pytorch-tensor-correctness-ubu2604](https://github.com/garys-gpu-benchmarks/405-gpu-bench-nvidia-pytorch-tensor-correctness-ubu2604)
- **406** - `benchmarks/nvidia-u26-406` - [406-sys-bench-nvidia-fio-nvme-sweep-ubu2604](https://github.com/garys-gpu-benchmarks/406-sys-bench-nvidia-fio-nvme-sweep-ubu2604)
- **407** - `benchmarks/nvidia-u26-407` - [407-sys-bench-nvidia-stream-ddr5-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/407-sys-bench-nvidia-stream-ddr5-bandwidth-ubu2604)
- **408** - `benchmarks/nvidia-u26-408` - [408-sys-bench-nvidia-iperf3-network-performance-ubu2604](https://github.com/garys-gpu-benchmarks/408-sys-bench-nvidia-iperf3-network-performance-ubu2604)
- **409** - `benchmarks/nvidia-u26-409` - [409-sys-bench-nvidia-multichase-numa-latency-ubu2604](https://github.com/garys-gpu-benchmarks/409-sys-bench-nvidia-multichase-numa-latency-ubu2604)
- **410** - `benchmarks/nvidia-u26-410` - [410-sys-bench-nvidia-numa-cache-performance-ubu2604](https://github.com/garys-gpu-benchmarks/410-sys-bench-nvidia-numa-cache-performance-ubu2604)
- **411** - `benchmarks/nvidia-u26-411` - [411-sys-bench-nvidia-linux-perf-pmu-ubu2604](https://github.com/garys-gpu-benchmarks/411-sys-bench-nvidia-linux-perf-pmu-ubu2604)
- **412** - `benchmarks/nvidia-u26-412` - [412-sys-bench-nvidia-lmbench-microbench-suite-ubu2604](https://github.com/garys-gpu-benchmarks/412-sys-bench-nvidia-lmbench-microbench-suite-ubu2604)
- **413** - `benchmarks/nvidia-u26-413` - [413-sys-bench-nvidia-gups-random-memory-ubu2604](https://github.com/garys-gpu-benchmarks/413-sys-bench-nvidia-gups-random-memory-ubu2604)
- **414** - `benchmarks/nvidia-u26-414` - [414-gpu-bench-nvidia-memcpy-transfer-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/414-gpu-bench-nvidia-memcpy-transfer-bandwidth-ubu2604)
- **415** - `benchmarks/nvidia-u26-415` - [415-gpu-bench-nvidia-babelstream-hbm-bandwidth-ubu2604](https://github.com/garys-gpu-benchmarks/415-gpu-bench-nvidia-babelstream-hbm-bandwidth-ubu2604)
- **416** - `benchmarks/nvidia-u26-416` - [416-gpu-bench-nvidia-nccl-bandwidth-test-ubu2604](https://github.com/garys-gpu-benchmarks/416-gpu-bench-nvidia-nccl-bandwidth-test-ubu2604)
- **417** - `benchmarks/nvidia-u26-417` - [417-gpu-bench-nvidia-gemm-cublas-micro-ubu2604](https://github.com/garys-gpu-benchmarks/417-gpu-bench-nvidia-gemm-cublas-micro-ubu2604)
- **418** - `benchmarks/nvidia-u26-418` - [418-gpu-bench-nvidia-cudnn-convolution-micro-ubu2604](https://github.com/garys-gpu-benchmarks/418-gpu-bench-nvidia-cudnn-convolution-micro-ubu2604)
- **419** - `benchmarks/nvidia-u26-419` - [419-gpu-bench-nvidia-torch-micro-suite-ubu2604](https://github.com/garys-gpu-benchmarks/419-gpu-bench-nvidia-torch-micro-suite-ubu2604)
- **420** - `benchmarks/nvidia-u26-420` - [420-gpu-bench-nvidia-linpack-hpl-fp64-ubu2604](https://github.com/garys-gpu-benchmarks/420-gpu-bench-nvidia-linpack-hpl-fp64-ubu2604)
- **421** - `benchmarks/nvidia-u26-421` - [421-gpu-bench-nvidia-resnet50-pytorch-training-ubu2604](https://github.com/garys-gpu-benchmarks/421-gpu-bench-nvidia-resnet50-pytorch-training-ubu2604)
- **422** - `benchmarks/nvidia-u26-422` - [422-gpu-bench-nvidia-resnet50-pytorch-inference-ubu2604](https://github.com/garys-gpu-benchmarks/422-gpu-bench-nvidia-resnet50-pytorch-inference-ubu2604)
- **423** - `benchmarks/nvidia-u26-423` - [423-gpu-bench-nvidia-bert-base-inference-ubu2604](https://github.com/garys-gpu-benchmarks/423-gpu-bench-nvidia-bert-base-inference-ubu2604)
- **424** - `benchmarks/nvidia-u26-424` - [424-gpu-bench-nvidia-sdxl-diffusers-latency-ubu2604](https://github.com/garys-gpu-benchmarks/424-gpu-bench-nvidia-sdxl-diffusers-latency-ubu2604)
- **425** - `benchmarks/nvidia-u26-425` - [425-gpu-bench-nvidia-distilbert-hf-classification-ubu2604](https://github.com/garys-gpu-benchmarks/425-gpu-bench-nvidia-distilbert-hf-classification-ubu2604)
- **426** - `benchmarks/nvidia-u26-426` - [426-gpu-bench-nvidia-jax-xla-forwardpass-ubu2604](https://github.com/garys-gpu-benchmarks/426-gpu-bench-nvidia-jax-xla-forwardpass-ubu2604)
- **427** - `benchmarks/nvidia-u26-427` - [427-gpu-bench-nvidia-vllm-kvcache-stress-ubu2604](https://github.com/garys-gpu-benchmarks/427-gpu-bench-nvidia-vllm-kvcache-stress-ubu2604)
- **428** - `benchmarks/nvidia-u26-428` - [428-gpu-bench-nvidia-vllm-throughput-latency-ubu2604](https://github.com/garys-gpu-benchmarks/428-gpu-bench-nvidia-vllm-throughput-latency-ubu2604)
- **429** - `benchmarks/nvidia-u26-429` - [429-gpu-bench-nvidia-vllm-mistral-cuda-ubu2604](https://github.com/garys-gpu-benchmarks/429-gpu-bench-nvidia-vllm-mistral-cuda-ubu2604)
- **430** - `benchmarks/nvidia-u26-430` - [430-gpu-bench-nvidia-sglang-prompt-response-ubu2604](https://github.com/garys-gpu-benchmarks/430-gpu-bench-nvidia-sglang-prompt-response-ubu2604)
- **431** - `benchmarks/nvidia-u26-431` - [431-gpu-bench-nvidia-sglang-serving-latency-ubu2604](https://github.com/garys-gpu-benchmarks/431-gpu-bench-nvidia-sglang-serving-latency-ubu2604)
- **432** - `benchmarks/nvidia-u26-432` - [432-gpu-bench-nvidia-rag-faiss-end2end-ubu2604](https://github.com/garys-gpu-benchmarks/432-gpu-bench-nvidia-rag-faiss-end2end-ubu2604)
