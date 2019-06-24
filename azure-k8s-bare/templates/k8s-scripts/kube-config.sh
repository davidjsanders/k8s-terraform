#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/kube-config.sh
# Environments:   all
# Purpose:        Copy and setup the k8s admin config file into a
#                 ~/.kube directory and change ownership to the
#                 admin user.
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

banner "kube-config.sh" "Setup k8s configuration"

echo "*** $(date) *** make .kube directory"
mkdir -p $HOME/.kube
sleep 2

echo "*** $(date) *** copy config"
sudo cp -if /etc/kubernetes/admin.conf $HOME/.kube/config
sleep 2

echo "*** $(date) *** change config owner to $(id -u):$(id -g)"
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 2
