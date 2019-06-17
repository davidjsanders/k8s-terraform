#!/bin/bash
source ~/scripts/banner.sh
banner "apt-upgrades.sh" "Do apt-get upgrade (non-interactive)"

echo "*** $(date) *** apt-get upgrade --yes"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        --yes \
        upgrade
sleep 2

echo "*** $(date) *** apt-get dist-update --yes"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
         --yes \
        dist-upgrade
sleep 2
