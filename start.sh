#!/bin/bash

# First, we need to resolve the IP address of the seed node
seed=$(/usr/bin/dig @169.254.169.250 +short aerospike | /usr/bin/tail -1)
/bin/sed -i -e "s/SEED_NODE/$seed/g" /etc/aerospike/aerospike.conf

# Print out DNS info to logs
dig @169.254.169.250 aerospike

# Start aerospike
/usr/bin/asd --foreground