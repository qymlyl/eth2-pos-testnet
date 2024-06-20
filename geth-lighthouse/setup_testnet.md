
## geth+lighthouse
停止两个小时之后重新启动，正常出块 <br/>
停止六个小时之后重新启动，正常出块
### 部署环境
进入到`geth-lighthouse`目录
```shell
cd geth-lighthouse
```
#### 生成创世信息
```shell
make generate_genesis_data
```
#### 初始化geth
```shell
make init_geth_genesis
```
#### 运行
```shell
./first_start
```
#### 停止
```shell
./stop
```
#### 重启
```shell
./restart
```
#### 删除容器并清除数据
```shell
make down_and_clean
```
### chainId修改
chainId的修改需要修改两个位置
1. 修改`genesis_data/values.env`中的`CHAIN_ID`
2. 修改`docker-compose.yaml`中`service.geth`的`--networkid=`
### 重新生成validator-keys
使用工具`eth2-val-tools`生成validator-keys， 首选需要buildeth2-val-tools
```shell
make eth2_val_tools
```
生成validator-keys
```shell
make reset_validator_keys
```
**注：** `genesis_data/reset_validator_keys.sh`中的`source-mnemonic`要与`genesis_data/values.env`中的`EL_AND_CL_MNEMONIC`一致

### 带着浏览器启动
区块链浏览器: blocksout <br/>
blob浏览器: blobscan <br/>
**注：** blocksout也是支持blob查看的，暂未配置成功，且blockout的`constract verify`功能暂未配置成功<br/>
进入到`geth-lighthouse`目录
```shell
cd geth-lighthouse
```
#### 注意事项
blocksout目前只有linux/amd64平台的镜像 <br/>

`docker-compose-explorer.yaml`中的`service.blockscout-frontend`下的`environment`环境变量中，`NEXT_PUBLIC_API_HOST`、`NEXT_PUBLIC_STATS_API_HOST`、`NEXT_PUBLIC_APP_HOST`、`NEXT_PUBLIC_VISUALIZE_API_HOST`需要配置为**宿主机的IP**<br/>

`service.blockscout-frontend`下的`environment`环境变量中`NEXT_PUBLIC_API_PORT`、`NEXT_PUBLIC_STATS_API_HOST`和`NEXT_PUBLIC_VISUALIZE_API_HOST`中的端口配置需要和`blockscout-proxy`中ports配置一样，这三个端口是必须暴露的，这三个端口是blocksout的前端页面发送的请求，所以blocksout-frontend需要配置所在宿主机的ip

#### 生成创世信息
```shell
make generate_genesis_data
```
#### 初始化geth
```shell
make init_geth_genesis
```
#### 运行
```shell
make first_start_with_explorer
```
#### 停止
```shell
make stop_with_explorers
```
#### 重启
```shell
make restart_with_explorer
```
#### 删除容器并清除数据
```shell
make down_and_clean_with_explorer
```
#### geth RPC端口
geth rpc端口: 8545

#### 区块链浏览器访问
浏览器访问:http://192.168.17.11:18000/

#### blobscan访问
浏览器访问:http://192.168.17.11:13000/

### 测试账户
>地址：0x8943545177806ED17B9F23F0a21ee5948eCaa776<br/>
私钥：bcdf20249abf0ed6d944c0288fad489e33f66b3960d9e6229c1cd214ed3bbe31<br/>

>地址：0xE25583099BA105D9ec0A67f5Ae86D90e50036425<br/>
私钥：39725efee3fb28614de3bacaffe4cc4bd8c436257e2c8bb887c4b5c4be45e76d<br/>


>地址：0x614561D2d143621E126e87831AEF287678B442b8<br/>
私钥：53321db7c1e331d93a11a41d16f004d7ff63972ec8ec7c25db329728ceeb1710<br/>


>地址：0xf93Ee4Cf8c6c40b329b0c0626F28333c132CF241<br/>
私钥：ab63b23eb7941c1251757e24b3d2350d2bc05c3c388d06f8fe6feafefb1e8c70<br/>


>地址：0x802dCbE1B1A97554B4F50DB5119E37E8e7336417<br/>
私钥：5d2344259f42259f82d2c140aa66102ba89b57b4883ee441a8b312622bd42491<br/>


>地址：0xAe95d8DA9244C37CaC0a3e16BA966a8e852Bb6D6<br/>
私钥：27515f805127bebad2fb9b183508bdacb8c763da16f54e0678b16e8f28ef3fff<br/>


>地址：0x2c57d1CFC6d5f8E4182a56b4cf75421472eBAEa4<br/>
私钥：7ff1a4c1d57e5e784d327c4c7651e952350bc271f156afb3d00d20f5ef924856<br/>


>地址：0x741bFE4802cE1C4b5b00F9Df2F5f179A1C89171A<br/>
私钥：3a91003acaf4c21b3953d94fa4a6db694fa69e5242b2e37be05dd82761058899<br/>


>地址：0xc3913d4D8bAb4914328651C2EAE817C8b78E1f4c<br/>
私钥：bb1d0f125b4fb2bb173c318cdead45468474ca71474e2247776b2b4c0fa2d3f5<br/>


>地址：0x65D08a056c17Ae13370565B04cF77D2AfA1cB9FA<br/>
私钥：850643a0224065ecce3882673c21f56bcf6eef86274cc21cadff15930b59fc8c<br/>


>地址：0x3e95dFbBaF6B348396E6674C7871546dCC568e56<br/>
私钥：94eb3102993b41ec55c241060f47daa0f6372e2e3ad7e91612ae36c364042e44<br/>


>地址：0x5918b2e647464d4743601a865753e64C8059Dc4F<br/>
私钥：daf15504c22a352648a71ef2926334fe040ac1d5005019e09f6c979808024dc7<br/>


>地址：0x589A698b7b7dA0Bec545177D3963A2741105C7C9<br/>
私钥：eaba42282ad33c8ef2524f07277c03a776d98ae19f581990ce75becb7cfa1c23<br/>


>地址：0x4d1CB4eB7969f8806E2CaAc0cbbB71f88C8ec413<br/>
私钥：3fd98b5187bf6526734efaa644ffbb4e3670d66f5d0268ce0323ec09124bff61<br/>


>地址：0xF5504cE2BcC52614F121aff9b93b2001d92715CA<br/>
私钥：5288e2f440c7f0cb61a9be8afdeb4295f786383f96f5e35eb0c94ef103996b64<br/>


>地址：0xF61E98E7D47aB884C244E39E031978E33162ff4b<br/>
私钥：f296c7802555da2a5a662be70e078cbd38b44f96f8615ae529da41122ce8db05<br/>


>地址：0xf1424826861ffbbD25405F5145B5E50d0F1bFc90<br/>
私钥：bf3beef3bd999ba9f2451e06936f0423cd62b815c9233dd3bc90f7e02a1e8673<br/>


>地址：0xfDCe42116f541fc8f7b0776e2B30832bD5621C85<br/>
私钥：6ecadc396415970e91293726c3f5775225440ea0844ae5616135fd10d66b5954<br/>


>地址：0xD9211042f35968820A3407ac3d80C725f8F75c14<br/>
私钥：a492823c3e193d6c595f37a18e3c06650cf4c74558cc818b16130b293716106f<br/>

>地址：0xD8F3183DEF51A987222D845be228e0Bbb932C222<br/>
私钥：c5114526e042343c6d1899cad05e1c00ba588314de9b96929914ee0df18d46b2<br/>