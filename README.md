# 以太坊2.0本地测试环境搭建
## 概述
提供三种方式：
1. kurtosis + ethereum-package (kurtosis不支持重启命令, 默认为geth+lighthouse)
2. geth + prysm (docker compose启动，不支持重启，重启不出块)
3. geth + lighthouse (docker compose启动，重启动正常出块) 

注：三种方式都依赖于docker

## ethereum-package
ethereum-package启动testnet查看文档:[ethereum-package/setup_testnet.md](ethereum-package%2Fsetup_testnet.md)

## geth+prysm
geth+prysm启动testnet查看文档[geth-prysm/setup_testnet.md](geth-prysm%2Fsetup_testnet.md)

## geth+lighthouse
geth+lighthouse启动testnet查看文档[geth-lighthouse/setup_testnet.md](geth-lighthouse%2Fsetup_testnet.md)