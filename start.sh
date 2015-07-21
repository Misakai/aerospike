#!/bin/bash
CFG=/etc/aerospike/aerospike.conf

# Wait until DNS comes up online
while [[ -z "${DNS_SEED}" ]]; do
	DNS_SEED=$(dig @169.254.169.250 +short aerospike | /usr/bin/tail -1)
    echo "Unable to get the list of seed nodes. Waiting 5s to retry..."
    sleep 5
done

# Set the seed DNS
sed -i -e "s/SEED_NODE/$DNS_SEED/g" $CFG

# Wait until we have an IP attached
while [[ -z "${ACCESS}" ]]; do
	ACCESS=$(ip addr show eth0 | awk '{print $2}' | grep -E -o "(10.*)" | cut -f1 -d'/')
    echo "Unable to get the access address. Waiting 5s to retry..."
    sleep 5
done

# Set the access address
sed -i -e "s/ACCESS_NODE/$ACCESS/g" $CFG

# Start aerospike
/usr/bin/asd --foreground