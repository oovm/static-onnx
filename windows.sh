#git clone https://github.com/microsoft/onnxruntime.git --recursive --depth 1
python3 ./onnxruntime/tools/ci_build/build.py \
  --cmake_generator "Visual Studio 17 2022" \
  --build_dir ./release/ \
  --config Release \
  --parallel 8 \
  --use_cuda \
  --cuda_version 11.6 \
  --cuda_home "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.6" \
  --cudnn_home "./CUDNN-8.8.1.3" \
  --use_tensorrt \
  --tensorrt_home "./TensorRT-8.5.3.1" \
  --enable_msvc_static_runtime \
  --skip_tests \
  --skip_submodule_sync