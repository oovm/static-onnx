从

作为一个主力是微软维护的项目, 想来在 Windows 上编译会非常简单吧?

这你就年轻了, 坑的就是 Windows 用户.

## Requirements

首先安装 [Visual Studio](https://visualstudio.microsoft.com/zh-hans/), 因为装 CUDA 会检测 VS 然后魔改

不然你要自己去改 MSBuildExtensions 及其配置, 比较复杂, 立马痛苦面具

我的评价是, **不如重装 CUDA**

---

VS 装的时候把第一个 C++ 勾上就行

![img.png](img.png)

我们只要 C++ MSVC 工具链, 外加 Windows SDK, 不需要 VS!!!

用 VS 打开项目立马卡死, 外加生成一堆垃圾...

然后在 Build 里改改改改半天, 最后也不是不能成功, 就是过程极度痛苦...

VS 版本关系到后面的编译参数, 具体为:

| VS Version | `--cmake_generator`     |
|------------|-------------------------|
| 2017       | `Visual Studio 15 2017` |
| 2019       | `Visual Studio 16 2019` |
| 2022       | `Visual Studio 17 2022` |

然后看需要哪些版本的 Cuda/TensorRT

- [TensorRT](https://onnxruntime.ai/docs/execution-providers/TensorRT-ExecutionProvider.html#requirements)
- [CUDA](https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#requirements)

|      ONNX | CUDA | TensorRT |
|----------:|-----:|---------:|
|      1.14 | 11.6 |      8.5 |
| 1.12-1.13 | 11.4 |      8.4 |
|      1.11 | 11.4 |      8.2 |
|      1.10 | 11.4 |      8.0 |

查表找对应的版本下载, 不要下最新的, 不然痛苦面具又要戴上

- [CUDA](https://developer.nvidia.com/cuda-toolkit-archive)
- [cuDNN](https://developer.nvidia.com/rdp/cudnn-archive)
- [TensorRT](https://developer.nvidia.com/nvidia-tensorrt-7x-archive)

然后可以开始 clone 了, 用 `--recursive` 是因为要下载 submodules, 用 `--depth 1` 是因为不需要历史记录

```sh
git clone https://github.com/microsoft/onnxruntime.git --recursive --depth 1
```

submodule 可能会失败, 失败了也别管, 丢失的那部分和编译没任何关系

## Build

然后别去看 CMAKE, 看了立马带上痛苦面具, 有个好东西叫 `build.py`

```shell
python3 ./onnxruntime/tools/ci_build/build.py \
  --cmake_generator "Visual Studio 17 2022" \
  --build_dir ./release/ \
  --config Release \
  --parallel 8 \
  --use_cuda \
  --cuda_version 11.6 \
  --cuda_home "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.6" \
  --cudnn_home "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.6" \
  --use_tensorrt \
  --tensorrt_home "./TensorRT-8.5.3.1" \
  --enable_msvc_static_runtime \
  --skip_tests \
  --skip_submodule_sync
```

- `--skip_submodule_sync`: 因为种种原因, submodule 问题很多, 跳过别管最好
- `--enable_msvc_static_runtime`: 静态链接 msvc, windows 默认开启的, 我怕他哪天 cmake 改了, 保险起见手动开启下

然后配下 CUDA, CUDNN,TensorRT 路径, 没写的话会去读环境变量, 但我这个机器里面有六个 CUDA, 还是手动标记下吧.

然后 intel 7 代以后的电脑都有 AVX, 白嫖的性能, AVX512 就别开了, 买也别买.

