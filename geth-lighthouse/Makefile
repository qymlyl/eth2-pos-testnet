PWD_DIR := $(shell pwd)
ARCH := $(shell uname -m)

pull_images:
	@echo "Pull ethereum-genesis-generator"
	docker pull ethpandaops/ethereum-genesis-generator:3.2.1

	@echo "Pull geth"
	docker pull ethereum/client-go:latest
	@echo ""

	@echo "Pull lighthouse"
	docker pull sigp/lighthouse:latest-unstable
	@echo ""

	@echo "Pull blocksout components"
	docker pull postgres:15
	docker pull redis:alpine
	docker pull ghcr.io/blockscout/visualizer:latest
	docker pull ghcr.io/blockscout/sig-provider:latest
	docker pull ghcr.io/blockscout/smart-contract-verifier:latest
	docker pull blockscout/blockscout:latest
	docker pull ghcr.io/blockscout/frontend:latest
	docker pull ghcr.io/blockscout/stats:latest
	docker pull nginx:latest
	@echo ""

	@echo "Pull blobscan components"
	docker pull blossomlabs/blobscan:stable
	docker pull blossomlabs/blobscan-indexer:master

save_images:
	mkdir -p export_images

	@echo "Save genesis-generator"
	docker save -o ethpandaops-ethereum-genesis-generator-3_2-1.img ethpandaops/ethereum-genesis-generator:3.2.1

	@echo "Save geth"
	docker save -o export_images/ethereum-client-go-latest.img ethereum/client-go:latest
	@echo ""

	@echo "Save lighthouse"
	docker save -o export_images/sigp-lighthouse-latest-unstable.img sigp/lighthouse:latest-unstable
	@echo ""
	
	@echo "Save blocksout components"
	docker save -o export_images/postgres-15.img postgres:15
	docker save -o export_images/redis-alpine.img redis:alpine
	docker save -o export_images/ghcr_io-blockscout-visualizer-latest.img ghcr.io/blockscout/visualizer:latest
	docker save -o export_images/ghcr_io-blockscout-sig-provider-latest.img ghcr.io/blockscout/sig-provider:latest
	docker save -o export_images/ghcr_io-blockscout-smart-contract-verifier-latest.img ghcr.io/blockscout/smart-contract-verifier:latest
	docker save -o export_images/blockscout-blockscout-latest.img blockscout/blockscout:latest
	docker save -o export_images/ghcr_io-blockscout-frontend-latest.img ghcr.io/blockscout/frontend:latest
	docker save -o export_images/ghcr_io-blockscout-stats-latest.img ghcr.io/blockscout/stats:latest
	docker save -o export_images/nginx-latest.img nginx:latest
	@echo ""

	@echo "Save blobscan components"
	docker save -o export_images/blossomlabs-blobscan-stable.img blossomlabs/blobscan:stable
	docker save -o export_images/blossomlabs-blobscan-indexer-master.img blossomlabs/blobscan-indexer:master

# 构建eth2-val-tools
eth2_val_tools:
	@echo "Init git submodule"
	@git submodule update --init --recursive
	@echo "Build eth2-val-tools, target path: tools/bin/eth2-val-tools"
	@cd tools/eth2-val-tools && go build -o ../bin/eth2-val-tools

# 定义目标：生成新的密钥
reset_validator_keys:
	@echo "Removing old validator-keys directory"
	@rm -rf genesis_data/validator-keys

	@echo "Generating new validator keys"
	@cd genesis_data && ./reset_validator_keys.sh

# 生成genesis_data
generate_genesis_data:
	@echo "Generate genesis-data"
	@cd genesis_data && ./generate_genesis_data.sh

# 初始化geth的创世信息
init_geth_genesis:
	@echo "Init geth gensis"
	@docker run --rm -it -u $UID \
	-v $(PWD_DIR)/data/execution-data:/execution-data \
	-v $(PWD_DIR)/genesis_data/el-cl-genesis-data:/el-cl-genesis-data \
	ethereum/client-go:latest \
	--datadir=/execution-data \
	init /el-cl-genesis-data/network-configs/genesis.json

# 停止并删除容器和数据
down_and_clean:
	@echo "Down container and clean data"
	@echo "Composer down"
	@docker compose down
	@echo ""

	@echo "Delete validator data..."
	rm -rf genesis_data/validator-keys/keys/logs
	rm -rf genesis_data/validator-keys/keys/.secp-sk
	rm -rf genesis_data/validator-keys/keys/api-token.txt
	rm -rf genesis_data/validator-keys/keys/slashing_protection.sqlite
	rm -rf genesis_data/validator-keys/keys/slashing_protection.sqlite-journal
	rm -rf genesis_data/validator-keys/keys/validator_definitions.yml
	rm -rf genesis_data/validator-keys/keys/validator_key_cache.json
	@echo ""

	@echo "Delete geth data..."
	rm -rf data/consensus-data
	@echo ""

	@echo "Delete lighthouse data..."
	rm -rf data/execution-data

	@echo "Delete blocksout data"
	rm -rf data/blockscout-data

	@echo "Delete el-cl-genesis-data"
	rm -rf genesis_data/el-cl-genesis-data
	@echo ""

	rm -rf data

first_start_with_explorer:
	@docker compose -f docker-compose-explorer.yaml up -d

stop_with_explorer:
	@docker compose -f docker-compose-explorer.yaml stop

restart_with_explorer:
	@docker compose -f docker-compose-explorer.yaml start

down_and_clean_with_explorer:
	@echo "Down container and clean data"
	@echo "Composer down"
	@docker compose -f docker-compose-explorer.yaml down
	@echo ""

	@echo "Delete validator data..."
	rm -rf genesis_data/validator-keys/keys/logs
	rm -rf genesis_data/validator-keys/keys/.secp-sk
	rm -rf genesis_data/validator-keys/keys/api-token.txt
	rm -rf genesis_data/validator-keys/keys/slashing_protection.sqlite
	rm -rf genesis_data/validator-keys/keys/slashing_protection.sqlite-journal
	rm -rf genesis_data/validator-keys/keys/validator_definitions.yml
	rm -rf genesis_data/validator-keys/keys/validator_key_cache.json
	@echo ""

	@echo "Delete geth data..."
	rm -rf data/consensus-data
	@echo ""

	@echo "Delete lighthouse data..."
	rm -rf data/execution-data

	@echo "Delete blocksout data"
	rm -rf data/blockscout-data

	echo "Delete blobscan data"
	rm -rf ./data/blobscan-data

	@echo "Delete el-cl-genesis-data"
	rm -rf genesis_data/el-cl-genesis-data
	@echo ""

	rm -rf data