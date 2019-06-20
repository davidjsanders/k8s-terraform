#!/bin/bash
source ~/scripts/banner.sh
banner "install-nfs-server.sh" "Installing NFS kernel server"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -y install \
            nfs-kernel-server \
            nfs-common
