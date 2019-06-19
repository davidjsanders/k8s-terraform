#!/usr/bin/env bash
uuid=$(sudo -i blkid | grep /dev/sdc1 | awk '{print $2}' | sed -e 's/UUID="\(.*\)\"/\1/')
echo "UUID=${uuid}   /datadrive   ext4   defaults,nofail   1   2" | sudo tee -a /etc/fstab
