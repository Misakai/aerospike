#!/bin/bash
seed=$(/usr/bin/dig +short aerospike | /usr/bin/tail -1)
/bin/sed -i -e 's/SEED_NODE/$seed/g' /etc/aerospike/aerospike.conf
/usr/bin/asd --foreground