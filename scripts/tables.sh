#!/bin/bash 

NODE_EOS=192.168.0.105

echo "player1"
cleos -u http://${NODE_EOS}:8800 get table eosdatavault player1 datavault -l 100 

echo "player2"
cleos -u http://${NODE_EOS}:8800 get table eosdatavault player2 datavault -l 100 
