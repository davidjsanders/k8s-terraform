#!/bin/bash
source ~/scripts/banner.sh

banner "apt-upgrades.sh" "Do apt-get upgrade (non-interactive)"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        --yes \
        upgrade
sleep 2

banner "apt-upgrades.sh" "Do apt-get dist-upgrade (non-interactive)"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
         --yes \
        dist-upgrade
sleep 2
