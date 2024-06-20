## ethereum-package
### ethereum-package介绍与使用
https://ethpandaops.io/posts/kurtosis-deep-dive/
### kurtosis安装
官方安装教程：https://docs.kurtosis.com/install/ <br/>
如果因为网络问题不好安装，可以下载源码手动build<br/>
源码下载
```shell
git clone --depth=1 -b 0.90.1 https://github.com/kurtosis-tech/kurtosis.git
```
依赖拉取
```shell
go work sync
```
直接build可能会报错
```shell
$ cd cli/cli && go build -o kurtosis    
../../engine/launcher/engine_server_launcher/engine_server_launcher.go:13:2: no required module provides package github.com/kurtosis-tech/kurtosis/kurtosis_version; to add it:
	go get github.com/kurtosis-tech/kurtosis/kurtosis_version
```
解决方案
```shell
echo 'package kurtosis_version
const KurtosisVersion = "0.90.1"' > ../../kurtosis_version/version.go
```
重新build
```shell
go build -o kurtosis
```

### 默认配置文件
```shell
vim network_params.yaml
```
```yaml
participants:
# EL
  - el_type: geth
    el_image: ethereum/client-go:latest
    el_log_level: ""
    el_extra_env_vars: {}
    el_extra_labels: {}
    el_extra_params: []
    el_tolerations: []
    el_volume_size: 0
    el_min_cpu: 0
    el_max_cpu: 0
    el_min_mem: 0
    el_max_mem: 0
# CL
    cl_type: lighthouse
    cl_image: sigp/lighthouse:latest-unstable
    cl_log_level: ""
    cl_extra_env_vars: {}
    cl_extra_labels: {}
    cl_extra_params: []
    cl_tolerations: []
    cl_volume_size: 0
    cl_min_cpu: 0
    cl_max_cpu: 0
    cl_min_mem: 0
    cl_max_mem: 0
    use_separate_vc: true
# Validator
    vc_type: lighthouse
    vc_image: sigp/lighthouse:latest-unstable
    vc_log_level: ""
    vc_count: 1
    vc_extra_env_vars: {}
    vc_extra_labels: {}
    vc_extra_params: []
    vc_tolerations: []
    vc_min_cpu: 0
    vc_max_cpu: 0
    vc_min_mem: 0
    vc_max_mem: 0
    validator_count: null
# participant specific
    node_selectors: {}
    tolerations: []
    count: 2
    snooper_enabled: false
    ethereum_metrics_exporter_enabled: false
    xatu_sentry_enabled: false
    prometheus_config:
      scrape_interval: 15s
      labels: {}
    blobber_enabled: false
    blobber_extra_params: []
    builder_network_params: null
    keymanager_enabled: false
network_params:
  network: kurtosis
  network_id: "3151908"
  deposit_contract_address: "0x4242424242424242424242424242424242424242"
  seconds_per_slot: 12
  num_validator_keys_per_node: 64
  preregistered_validator_keys_mnemonic:
    "giant issue aisle success illegal bike spike
    question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy
    very lucky have athlete"
  preregistered_validator_count: 0
  genesis_delay: 20
  max_per_epoch_activation_churn_limit: 8
  churn_limit_quotient: 65536
  ejection_balance: 16000000000
  eth1_follow_distance: 2048
  min_validator_withdrawability_delay: 256
  shard_committee_period: 256
  deneb_fork_epoch: 0
  electra_fork_epoch: 100000000
  eip7594_fork_epoch: 100000001
  eip7594_fork_version: "0x70000038"
  network_sync_base_url: https://ethpandaops-ethereum-node-snapshots.ams3.cdn.digitaloceanspaces.com/
  data_column_sidecar_subnet_count: 32
  samples_per_slot: 8
  custody_requirement: 1
  target_number_of_peers: 70
  additional_preloaded_contracts: {}
additional_services:
  - tx_spammer
  - blob_spammer
  - el_forkmon
  - beacon_metrics_gazer
  - dora
  - prometheus_grafana
dora_params:
  image: ""
tx_spammer_params:
  tx_spammer_extra_args: []
goomy_blob_params:
  goomy_blob_args: []
assertoor_params:
  image: ""
  run_stability_check: true
  run_block_proposal_check: true
  run_transaction_test: false
  run_blob_transaction_test: false
  run_opcodes_transaction_test: false
  run_lifecycle_test: false
  tests: []
wait_for_finalization: false
global_log_level: info
snooper_enabled: false
ethereum_metrics_exporter_enabled: false
parallel_keystore_generation: false
disable_peer_scoring: false
grafana_additional_dashboards: []
persistent: false
mev_type: null
mev_params:
  mev_relay_image: flashbots/mev-boost-relay
  mev_builder_image: ethpandaops/flashbots-builder:main
  mev_builder_cl_image: sigp/lighthouse:latest
  mev_boost_image: flashbots/mev-boost
  mev_boost_args: ["mev-boost", "--relay-check"]
  mev_relay_api_extra_args: []
  mev_relay_housekeeper_extra_args: []
  mev_relay_website_extra_args: []
  mev_builder_extra_args: []
  mev_builder_prometheus_config:
    scrape_interval: 15s
    labels: {}
  mev_flood_image: flashbots/mev-flood
  mev_flood_extra_args: []
  mev_flood_seconds_per_bundle: 15
  custom_flood_params:
    interval_between_transactions: 1
xatu_sentry_enabled: false
xatu_sentry_params:
  xatu_sentry_image: ethpandaops/xatu-sentry
  xatu_server_addr: localhost:8000
  xatu_server_tls: false
  xatu_server_headers: {}
  beacon_subscriptions:
    - attestation
    - block
    - chain_reorg
    - finalized_checkpoint
    - head
    - voluntary_exit
    - contribution_and_proof
    - blob_sidecar
apache_port: 40000
global_tolerations: []
global_node_selectors: {}
keymanager_enabled: false
port_publisher:
  public_port_start: null
  nat_exit_ip: KURTOSIS_IP_ADDR_PLACEHOLDER
```
### testnet部署
如果要修改chainId, 需要修改`network_params.yaml`中的`network_params.network_id`<br/>
如果要修改execution node和beacon node的数量，需要修改`network_params.yaml`中的`participants.count`, 默认值为2，即会创建两个geth node 和两个lighouse beacon node </br>

#### 部署环境
```shell
kurtosis run --enclave my-testnet github.com/ethpandaops/ethereum-package
``` 
或者
```shell
kurtosis run --enclave my-testnet github.com/ethpandaops/ethereum-package --args-file network_params.yaml
```
如果`github.com/ethpandaops/ethereum-package`拉取失败，可以手动拉取，执行命令时指定ethereum-package的位置
```shell
git clone https://github.com/ethpandaops/ethereum-package.git
```
```shell
kurtosis run --enclave my-testnet --args-file network_params.yaml ./ethereum-package
```
#### 停止环境
```shell
kurtosis enclave stop my-testnet
```
#### 删除环境
```shell
kurtosis enclave rm my-testnet
```
#### 其他命令
查看所有的enclave
```shell
kurtosis enclave ls
```
查看enclave中的service
```shell
kurtosis enclave inspect my-testnet
```
### 默认组件
默认的execution node是geth, beacon node是lighthouse<br/>
其他工具配置在`network_params.yaml`中的`additional_services`, 默认为: <br/>
```yaml
  - tx_spammer
  - blob_spammer
  - el_forkmon
  - beacon_metrics_gazer
  - dora
  - prometheus_grafana
```
全部组件有:
```yaml
additional_services:
  - assertoor
  - broadcaster
  - tx_spammer
  - blob_spammer
  - custom_flood
  - goomy_blob
  - el_forkmon
  - blockscout
  - beacon_metrics_gazer
  - dora
  - full_beaconchain_explorer
  - prometheus_grafana
  - blobscan
  - dugtrio
  - blutgang
  - forky
  - apache
  - tracoor
```
**注：** 工具的具体功能与作用可参考:https://ethpandaops.io/posts/kurtosis-deep-dive 中的`Tooling`部分介绍

### 测试账户
测试账户: https://github.com/ethpandaops/ethereum-package/blob/main/src/prelaunch_data_generator/genesis_constants/genesis_constants.star <br/>
与geth+lighouse章节的测试账户一致，因为都是使用`eth2_val_tools`以相同的助记词生成的，助记词`giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete` 
