#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/install-nfs-server.sh
# Environments:   all
# Purpose:        Install and enable the NFS Server using the apt 
#                 package 
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

banner "install-nfs-server.sh" "Installing NFS kernel server"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -y install \
            nfs-kernel-server \
            nfs-common
