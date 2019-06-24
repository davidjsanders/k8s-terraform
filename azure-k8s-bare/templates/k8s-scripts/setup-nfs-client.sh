#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/setup-nfs-client.sh
# Environments:   all
# Purpose:        Setup the NFS client and write the required mounts
#                 into fstab
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "setup-nfs-client.sh" "Make mount points for NFS"
sudo mkdir -p /datadrive

banner "setup-nfs-client.sh" "Mount NFS /datadrive/export --> /nfs/data"
sudo mount k8s-master:/datadrive/export /datadrive

banner "setup-nfs-client.sh" "Write to fstab"
echo "k8s-master:/datadrive/export /datadrive   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee -a /etc/fstab
