#!/bin/bash

# First, we need to resolve the IP address of the seed node
seed=$(/usr/bin/dig @169.254.169.250 +short aerospike | /usr/bin/tail -1)
/bin/sed -i -e "s/SEED_NODE/$seed/g" /etc/aerospike/aerospike.conf

# Set the access address
access=$(ip addr show eth0 | awk '{print $2}' | grep -E -o "(10.*)" | cut -f1 -d'/')
/bin/sed -i -e "s/ACCESS_NODE/$access/g" /etc/aerospike/aerospike.conf

# Start aerospike
/usr/bin/asd --foreground