#!/bin/bash
source ~/scripts/banner.sh
banner "install-nfs-common.sh" "Installing NFS common"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -y install \
            nfs-common
