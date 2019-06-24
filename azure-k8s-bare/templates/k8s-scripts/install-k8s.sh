#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/install-k8s.sh
# Environments:   all
# Purpose:        Install and enable kubeadm, kubelet and kubectl
#                 at version 1.14.3-00
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

banner "install-k8s.sh" "apt-get install kubeadm, kubelet, kubectl - All 1.14.1-00"
sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -o Dpkg::Options::="--force-confold" \
  -q \
  --yes \
  install \
    kubeadm=1.14.3-00 \
    kubelet=1.14.3-00 \
    kubectl=1.14.3-00

sleep 2