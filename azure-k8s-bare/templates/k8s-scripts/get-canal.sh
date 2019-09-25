#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/get-canal.sh
# Environments:   all
# Purpose:        Download, configure(setup) and install Canal for
#                 in the cluster
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

banner "get-canal.sh" "Download, setup and install Canal"

echo "*** $(date) *** Get canal"
curl https://docs.projectcalico.org/v3.7/manifests/canal.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in canal.yaml"
POD_CIDR="192.168.0.0/16"
sed -i -e "s?10.244.0.0/16?$POD_CIDR?g" canal.yaml
#sed -i -e "s?10.244.0.0/16?192.168.0.0/16?g" canal.yaml
sleep 2

echo "*** $(date) *** Apply canal.yaml"
kubectl apply -f canal.yaml
sleep 2
