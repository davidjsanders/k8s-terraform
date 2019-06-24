#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/apt-updates.sh
# Environments:   all
# Purpose:        Perform an apt-get update and use the Debian
#                 parameters for non-interactive use.
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
banner "apt-updates.sh" "do apt-get update"

echo "*** $(date) *** apt-get update"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        update
sleep 2
