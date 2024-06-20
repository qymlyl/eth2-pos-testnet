rm -rf validator-keys

../tools/bin/eth2-val-tools keystores \
--insecure \
--prysm-pass password \
--out-loc validator-keys \
--source-mnemonic "giant issue aisle success illegal bike spike question tent bar rely arctic volcano long crawl hungry vocal artwork sniff fantasy very lucky have athlete" \
--source-min 0 \
--source-max 64