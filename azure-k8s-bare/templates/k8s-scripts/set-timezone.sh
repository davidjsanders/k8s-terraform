#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/set-timezone.sh
# Environments:   all
# Purpose:        Set the timezone to America/Toronto
#
# Created on:     24 July 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 24 Jul 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh
banner "set-timezone.sh" "do apt-get update"

sudo DEBIAN_FRONTEND=noninteractive \
        timedatectl set-timezone America/Toronto
sleep 2
