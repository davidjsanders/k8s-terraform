#!/bin/bash
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
