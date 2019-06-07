#!/bin/bash
echo "*** $(date) *** apt-get upgrade --yes"
sudo apt-get upgrade --yes
sleep 2

echo "*** $(date) *** apt-get dist-update --yes"
sudo apt-get dist-upgrade --yes
sleep 2
