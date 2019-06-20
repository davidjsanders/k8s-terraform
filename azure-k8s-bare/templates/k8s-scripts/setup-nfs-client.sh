#!/bin/bash
source ~/scripts/banner.sh

banner "setup-nfs-client.sh" "Make mount points for NFS"
sudo mkdir -p /datadrive

banner "setup-nfs-client.sh" "Mount NFS /datadrive/export --> /nfs/data"
sudo mount k8s-master:/datadrive/export /datadrive

banner "setup-nfs-client.sh" "Write to fstab"
echo "k8s-master:/datadrive/export /datadrive   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee -a /etc/fstab
