![MoM](./docs/src/assets/logo.png)
# MoM_AllinOne

![star](https://img.shields.io/github/stars/deltaeecs/MoM_AllinOne.jl?style=social)

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://deltaeecs.github.io/MoM_AllinOne.jl/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://deltaeecs.github.io/MoM_AllinOne.jl/dev/)
[![Build Status](https://github.com/deltaeecs/MoM_AllinOne.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/deltaeecs/MoM_AllinOne.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/deltaeecs/MoM_AllinOne.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/deltaeecs/MoM_AllinOne.jl)

![Size](https://img.shields.io/github/repo-size/deltaeecs/MoM_AllinOne.jl)
![Downloads](https://img.shields.io/github/downloads/deltaeecs/MoM_AllinOne.jl/total)
![License](https://img.shields.io/github/license/deltaeecs/MoM_AllinOne.jl)

## 介绍

本程序包提供 **矩量法（MoM） + 多层快速多极子算法（MFLFMA）** 分析电磁散射、辐射问题，基于 Julia 语言开发，多线程或 MPI 并行，支持如下问题的电磁散射、辐射仿真：

| 问题类型 | 积分方程 | 基函数类型 | MFLFMA |
| :----:  |  :----: |  :----:   | :----: |
| **PEC** | S-EFIE/S-MFIE/S-CFIE （面） | RWG | **√** |
| **介质** | V-EFIE （体） | SWG（四面体）/RBF（六面体屋顶基）<br>/PWC（四面体、六面体以及混合） | **√** |
| **PEC + 介质** | VS-EFIE （体表面） | RWG + SWG/RBF/PWC | **√** |

## 版权说明

* 程序版权属于北京大学电子学院电磁场与微波技术实验室夏明耀教授课题组，有合作需求请联系：[![Stable](https://img.shields.io/badge/夏明耀教授-myxia@pku.edu.cn-blue.svg)](myxia@pku.edu.cn) [![Stable](https://img.shields.io/badge/贺晓阳-1801111302@pku.edu.cn-blue.svg)](1801111302@pku.edu.cn) [![Stable](https://img.shields.io/badge/张文炜-2201111526@stu.pku.edu.cn-blue.svg)](2201111526@pku.edu.cn).
* 本程序包采用 ![License](https://img.shields.io/github/license/deltaeecs/MoM_AllinOne.jl) 开源协议，免费提供给学术研究人员使用。该开源协议要求任何基于本程序包进一步开发的程序同样需要进行开源，因此不推荐商业环境使用，如违反开源协议课题组将保留追究法律责任的权力；
* Julia 的语言特性更适合作为学术界使用，商业环境有着更为严苛的要求，因此本包仅推荐学术研究人员使用，不推荐商业环境使用；
* 本包的的计算结果目前在已测试算例内与商业软件 Feko 结果吻合，无法保证其它所有情况下的适用，因此仍然仅推荐学术研究人员使用。

## 软件架构

MoM_AllinOne 程序的基本构成如下图所示:![MoM_AllinOne 包结构](deps/MoM_packages_relationship.png)
程序建立在Julia编程语言基础上，并根据功能拆分为数个子程序包。主要子程序包与其功能如下：

* [![MoM__Basics](https://img.shields.io/badge/MoM__Basics-orange.svg)](https://github.com/deltaeecs/MoM_Basics.jl) ：提供网格文件、基函数处理以及源的定义等相关基础功能；
* [![MoM__Kernels](https://img.shields.io/badge/MoM__Kernels-orange.svg)](https://github.com/deltaeecs/MoM_Kernels.jl)：提供矩阵、多层快速多极子构建、求解和后处理相关功能；
* [![MoM__Visualizing](https://img.shields.io/badge/MoM__Visualizing-green.svg)](https://github.com/deltaeecs/MoM_Visualizing.jl)：提供绘图等后处理可视化功能；
* [![MoM__MPI](https://img.shields.io/badge/MoM__MPI-blue.svg)](https://github.com/deltaeecs/MoM_MPI.jl)：提供基于MPI的分布式并行计算功能，未直接集成在 MoM_AllinOne 中，如需使用请跳转到该包主页；
* MoM_Distributed：提供基于Julia原生分布式并行计算功能，目前并不推荐使用，未进行开源；
* [![MoM__Lebedev](https://img.shields.io/badge/MoM__Lebedev-blue.svg)](https://github.com/deltaeecs/MoM_Lebedev.jl)：提供基于Lebedev球面矢量插值的计算功能，未直接集成在 MoM_AllinOne 中，如需使用请跳转到该包主页；

## 安装教程

1. 在本地安装 Julia，可参照 [Julia 中文社区相关指引](https://discourse.juliacn.com/t/topic/159)，建议配合 [VSCode](https://code.visualstudio.com/) 与 [Julia 插件](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)使用；

2. 在本地选定文件夹进入 Julia REPL (VScode 中快捷键为连按 alt+j, alt+o)：

    ```julia
    julia> 
    ```

    进入包管理（Pkg）模式（REPL中空白行输入`]`），并输入`add MoM_AllinOne`，Julia 的包管理模式中安装该包将自动配置包环境：

    ```julia
    (@v1.9) pkg> add MoM_AllinOne
    ```

    或 git clone 到本地：

    ```powwershell
    git clone https://gitee.com/deltaeecs/MoM_AllinOne.jl.git
    ```

    紧接着，在本包路径下（xxx/MoM_AllinOne）运行如下命令安装相关依赖包：

    ```powwershell
    julia -t 8 deps/install.jl
    ```

3. 测试，导入本包运行 `run_examples()` 函数即可自动运行 [examples](./examples/) 文件夹中的8个测试程序，并绘图比较与 Feko 的结果，图片（ `.pdf` 格式）保存在 [figures](./figures/) 文件夹中。

    ```julia
    using MoM_AllinOne
    run_examples()
    ```

## 使用说明

1. 参见 [examples](./examples/) 文件夹中的8个测试程序。

2. 更详细内容请参见文档 [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://deltaeecs.github.io/MoM_AllinOne.jl/)；

## TODO

我们鼓励程序使用者针对以下问题创建 PR，熟悉程序使用、成为该开源程序的贡献者：

* 为各包编写文档
* 丰富后处理函数
  * 远场3D可视化
  * 近场计算、可视化
  * 远场、近场计算快速算法
* 更多激励源、端口定义
* 其它类型积分方程
  * PMCHW
* 各向异性介质处理
* 特征模(CM)
