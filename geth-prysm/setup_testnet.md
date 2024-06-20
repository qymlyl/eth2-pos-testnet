## geth+prysm
### 环境部署
进入到`geth-prysm`目录中
```shell
cd geth-prysm
```
#### 注意事项
blocksout目前只有linux/amd64平台的镜像 <br/>

`docker-compose-explorer.yaml`中的`service.blockscout-frontend`下的`environment`环境变量中，`NEXT_PUBLIC_API_HOST`、`NEXT_PUBLIC_STATS_API_HOST`、`NEXT_PUBLIC_APP_HOST`、`NEXT_PUBLIC_VISUALIZE_API_HOST`需要配置为**宿主机的IP**<br/>

`service.blockscout-frontend`下的`environment`环境变量中`NEXT_PUBLIC_API_PORT`、`NEXT_PUBLIC_STATS_API_HOST`和`NEXT_PUBLIC_VISUALIZE_API_HOST`中的端口配置需要和`blockscout-proxy`中ports配置一样，这三个端口是必须暴露的，这三个端口是blocksout的前端页面发送的请求，所以blocksout-frontend需要配置所在宿主机的ip

#### 运行
```shell
./run.sh
```

#### 停止并删除容器
```shell
./stop_and_clean.sh
```
#### geth RPC端口
geth rpc端口: 8545

#### 区块链浏览器访问
浏览器访问:http://192.168.17.11:18000/

#### blobscan访问
浏览器访问:http://192.168.17.11:13000/

### chainId修改
1. 修改`components/execution/genesis.json`中的`chainId`
2. 修改`docker-compose.yml`中的`services.beacon-chain`下的`--chain-id`
3. 修改`docker-compose.yml`中的`blockscout-frontend`下的环境变量`NEXT_PUBLIC_NETWORK_NAME`、`NEXT_PUBLIC_NETWORK_ID`
### 测试账户
> 地址：123463a4b065722e99115d6c222f267d9cabb524 <br/>
> 私钥：2e0834786285daccd064ca17f1654f67b4aef298acbb82cef9ec422fb4975622
