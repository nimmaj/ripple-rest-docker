#!/bin/bash

IP_ADDRESS=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')

node server/server.js --host=${IP_ADDRESS}
