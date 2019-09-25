#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/apt-upgrade.sh
# Environments:   all
# Purpose:        Perform an apt upgrade and apt dist-upgrade so that
#                 packages are up to date. Use the Debian parameters
#                 for non-interactive use
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
