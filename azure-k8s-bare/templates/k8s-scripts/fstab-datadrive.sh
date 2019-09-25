#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/fstab-datadrive.sh
# Environments:   all
# Purpose:        Get the uuid for the permanent storage (assuming
#                 the device is /dev/sdc1) and write it into the
#                 fstab for mounting at boot-time.
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

banner "fstab-datadrive.sh" "Write /dev/sdc1 into fstab"

uuid=$(sudo -i blkid | grep /dev/sdc1 | awk '{print $2}' | sed -e 's/UUID="\(.*\)\"/\1/')
echo "UUID=${uuid}   /datadrive   ext4   defaults,nofail   1   2" | sudo tee -a /etc/fstab
