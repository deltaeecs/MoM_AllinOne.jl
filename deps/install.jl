## 激活环境
using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

## 安装包
pkgs = ["https://github.com/deltaeecs/IterativeSolvers.jl.git",]

map(pkgs) do pkg
    try
        Pkg.add(url = pkg)
    catch e
        @show e
    end
end

## 初始化
Pkg.instantiate()
