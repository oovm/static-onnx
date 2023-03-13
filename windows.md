git clone https://github.com/microsoft/onnxruntime.git --recursive --depth 1



## Requirements

- https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#requirements

然后找对应的版本下载

https://developer.nvidia.com/cuda-toolkit-archive

```
https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#requirements
cmake.exe --build D:\models\static-onnx\onnxruntime\cmake\cmake-build-release --target onnxruntime_providers -j 18
```