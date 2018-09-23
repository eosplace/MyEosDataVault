#!/bin/bash 

EOS_CONTRACTS=/home/trumae/eos/eosio/build/contracts
NODE_EOS=192.168.0.105
PORT=8899

echo "Stopping process/server" 
killall -9 nodeos
killall -9 keosd

echo "Cleaning database" 
rm -rf ~/.local/share/eosio
rm -rf ~/eosio-wallet

echo "Starting nodeos and keosd" 
keosd --http-server-address ${NODE_EOS}:${PORT} > /dev/null 2> /dev/null &
nodeos --contracts-console --config-dir . 2> nodeos.log &

echo "Waiting servers ... " 
sleep 3 

echo "Initializing wallet" 
cleos --wallet-url http://${NODE_EOS}:${PORT}  wallet create | tail -n 1 | cut -d'"' -f 2 > key.wallet 
cat key.wallet | cleos --wallet-url http://${NODE_EOS}:${PORT}  wallet unlock

echo "Importing keys" 
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} wallet import --private-key 5KEFmzRkaWXZh2XF3SkPenzsGMrfdJvDGapmjBbKwZrGfU2ZWxa

echo "Sending bios contract" 
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} set contract eosio ${EOS_CONTRACTS}/eosio.bios -p eosio 

echo "Creating system users"
for user in eosio.bpay eosio.msig eosio.names eosio.ram eosio.ramfee eosio.saving eosio.stake eosio.token eosio.vpay; do	    
   cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} create account eosio ${user} EOS7rMZfsA4yucaLyuEzAiBrhKj221qABT5zuKqtsq1Q1a1iVxe8M EOS7rMZfsA4yucaLyuEzAiBrhKj221qABT5zuKqtsq1Q1a1iVxe8M
done

echo "Sending eosio.token contract"
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} set contract eosio.token ${EOS_CONTRACTS}/eosio.token -p eosio.token

echo "Sending eosio.msig contract"
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} set contract eosio.msig ${EOS_CONTRACTS}/eosio.msig -p eosio.msig

echo "Creating eosdatavault user and registring contract" 
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT}  create account eosio eosdatavault EOS7rMZfsA4yucaLyuEzAiBrhKj221qABT5zuKqtsq1Q1a1iVxe8M EOS7rMZfsA4yucaLyuEzAiBrhKj221qABT5zuKqtsq1Q1a1iVxe8M
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} set contract eosdatavault ../contract/ -p eosdatavault

echo "Creating user1"
### Private key: 5JDM42HnuB1oVNWmdkcLPozEvMztyqnkVLdJDcqfD38NVht68ck
### Public key: EOS6pXfwZ976YHeNiRgWewX3ZTmmyTD5ej8RkWoQDQXw4J63zNnov
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} create account eosio user1 EOS7oWRkoquFbJstwms4bMUM2LB1qQ9kG8mZ7FjxEMFcCAre3miGu EOS6pXfwZ976YHeNiRgWewX3ZTmmyTD5ej8RkWoQDQXw4J63zNnov
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} wallet import --private-key 5JDM42HnuB1oVNWmdkcLPozEvMztyqnkVLdJDcqfD38NVht68ck

echo "Creating user2"
### Private key: 5J4sU5tBujAq6xdkQLuYohKPBFuTj4Er9fCtpBYmibrchNCe4L7
### Public key: EOS6AcefxUgbQQeK7hXRTyAn2gxgZmsRyKZLVFeUnWrY1p4oMo2Ee
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} create account eosio user2 EOS7oWRkoquFbJstwms4bMUM2LB1qQ9kG8mZ7FjxEMFcCAre3miGu EOS6AcefxUgbQQeK7hXRTyAn2gxgZmsRyKZLVFeUnWrY1p4oMo2Ee
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} wallet import --private-key 5J4sU5tBujAq6xdkQLuYohKPBFuTj4Er9fCtpBYmibrchNCe4L7

echo "Creating user3"
### Private key: 5KDSPKGxwnrhDWyczJW7MYs6HM2YaYorri1kN8gY4yx4FGDRSXf
### Public key: EOS6ZXD8W9ttK3PzypRpGmE7Y2pQq151k9jjEQc4LQq1rivk2Fpu1
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} create account eosio user3 EOS7oWRkoquFbJstwms4bMUM2LB1qQ9kG8mZ7FjxEMFcCAre3miGu EOS6ZXD8W9ttK3PzypRpGmE7Y2pQq151k9jjEQc4LQq1rivk2Fpu1
cleos -u http://${NODE_EOS}:8800 --wallet-url http://${NODE_EOS}:${PORT} wallet import --private-key 5KDSPKGxwnrhDWyczJW7MYs6HM2YaYorri1kN8gY4yx4FGDRSXf


