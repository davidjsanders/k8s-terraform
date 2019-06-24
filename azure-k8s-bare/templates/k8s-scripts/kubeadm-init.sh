#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/kubeadm-init.sh
# Environments:   all
# Purpose:        Initialize the k8s master node at 1.14.3 and set
#                 the CIDR block to be 192.168.0.0/16
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

banner "kubeadm-init.sh" "Perform kubeadm init"

echo "*** $(date) *** kubeadm init"
sudo kubeadm init \
    --kubernetes-version 1.14.3 \
    --pod-network-cidr 192.168.0.0/16
