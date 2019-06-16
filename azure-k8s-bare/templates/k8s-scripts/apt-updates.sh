#!/bin/bash
echo "*** $(date) *** apt-get update"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        update
sleep 2
