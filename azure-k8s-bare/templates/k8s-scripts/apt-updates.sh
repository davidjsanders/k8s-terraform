#!/bin/bash
source ~/scripts/banner.sh
banner "apt-updates.sh" "do apt-get update"

echo "*** $(date) *** apt-get update"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        update
sleep 2
