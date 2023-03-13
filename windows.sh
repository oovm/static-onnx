#git clone https://github.com/microsoft/onnxruntime.git --recursive --depth 1
python3 ./onnxruntime/tools/ci_build/build.py \
  --build_dir ./release/ \
  --config Release \
  --parallel 8 \
  --use_cuda \
  --cuda_version 10.6 \
  --cuda_home "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v10.2" \
  --cudnn_home "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v10.2" \
  --use_tensorrt \
  --tensorrt_home ./TensorRT-8.5.3.1 \
  --skip_tests \
  --skip_submodule_sync