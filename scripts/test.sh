#! //bin/bash

source ./setup.sh

cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["player1","datadatadatadata","pass"]' -p player1

cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["player1","datadatadatadata2","pass2"]' -p player1

cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} push action eosdatavault add '["player2","datadatadatadata3","pass3"]' -p player2
