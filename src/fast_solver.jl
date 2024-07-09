

# 更新参数
inputParameters(;frequency = frequency, ieT = ieT)
updateVSBFTParams!(;sbfT = sbfT, vbfT = vbfT)

# 网格文件读取
meshData, εᵣs   =  getMeshData(filename; meshUnit=meshUnit);

# 基函数生成
ngeo, nbf, geosInfo, bfsInfo =  getBFsFromMeshData(meshData; sbfT = sbfT, vbfT = vbfT)

# 设置介电参数
setGeosPermittivity!(geosInfo, 2(1-0.0002im))

## 快速算法
# 计算阻抗矩阵（MLFMA计算），注意此处根据基函数在八叉树的位置信息改变了基函数顺序
# Zopt, octree, ZnearCSC  =   getImpedanceOpt(geosInfo, bfsInfo);
nLevels, octree     =   getOctreeAndReOrderBFs!(geosInfo, bfsInfo; leafCubeEdgel = Precision.FT(0.23Params.λ_0), nInterp = 4);

# 叶层
leafLevel   =   octree.levels[nLevels];
# 计算近场矩阵CSC
ZnearCSC     =   calZnearCSC(leafLevel, geosInfo, bfsInfo);

# 构建矩阵向量乘积算子
Zopt  =   MLFMAIterator(ZnearCSC, octree, geosInfo, bfsInfo);

## 根据近场矩阵和八叉树计算 SAI 左预条件
Zprel    =   sparseApproximateInversePl(ZnearCSC, leafLevel)

# 激励向量
V    =   getExcitationVector(geosInfo, nbf, source);

# 求解
ICoeff, ch   =   solve(Zopt, V; solverT = solverT, Pl = Zprel, rtol = rtol, restart = restart);

using LinearAlgebra
@info norm(ZnearCSC) norm(V)
# RCS
RCSθsϕs, RCSθsϕsdB, RCS, RCSdB = radarCrossSection(θs_obs, ϕs_obs, ICoeff, geosInfo) 
