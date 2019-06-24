#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/hold.sh
# Environments:   all
# Purpose:        Mark the Docker and k8s apt packages as hold so
#                 that they are not updated with apt-get update
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

banner "install-k8s.sh" "apt-mark hold at 1.14.1-00"
sudo DEBIAN_FRONTEND=noninteractive \
  apt-mark hold \
    docker \
    kubeadm \
    kubelet \
    kubectl
