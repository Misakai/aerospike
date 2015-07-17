#!/bin/bash

# First, we need to resolve the IP address of the seed node
seed=$(/usr/bin/dig +short aerospike | /usr/bin/tail -1)
/bin/sed -i -e 's/SEED_NODE/$seed/g' /etc/aerospike/aerospike.conf
echo 'Aerospike seed node: $seed'

# Start aerospike
/usr/bin/asd --foreground