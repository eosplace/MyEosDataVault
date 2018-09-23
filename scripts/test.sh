#! //bin/bash

source ./setup.sh

cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["user1","datadatadatadata","pass"]' -p user1
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["user1","datadatadatadata2","pass2"]' -p user1
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["user2","datadatadatadata3","pass3"]' -p user2

cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault erase '["user1", 0]' -p  user1
