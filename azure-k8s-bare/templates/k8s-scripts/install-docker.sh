#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/install-docker.sh
# Environments:   all
# Purpose:        Install and enable Docker using the apt package 
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

banner "install-docker.sh" "Install Docker CE (latest), docker-compose and apache2-utils"

echo "*** $(date) *** apt-get install Docker, docker-compose and apache2-utils"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        --yes \
        install \
           docker.io \
           docker-compose \
           apache2-utils
sleep 2

echo "*** $(date) *** systemctl enable docker"
sudo systemctl enable docker.service
sleep 2
