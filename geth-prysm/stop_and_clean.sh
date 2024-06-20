docker compose down

echo "clean consensus data"
rm -rf ./components/consensus/beacondata 
rm -rf ./components/consensus/validatordata 
rm -rf ./components/consensus/genesis.ssz

echo "clean execution data"
rm -rf ./components/execution/geth

echo "clean blobscout data"
rm -rf ./components/blockscout/data

echo "clean blobscan data"
rm -rf ./components/blobscan/data