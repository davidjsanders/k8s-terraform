#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/get-calicao.sh
# Environments:   all
# Purpose:        Download, configure(setup) and install Calico for
#                 policy only in the cluster
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

banner "get-calico.sh" "Download, setup and install Calico (policy only)"

echo "*** $(date) *** Get calico policy only (v3.7)"
curl https://docs.projectcalico.org/v3.7/manifests/calico-policy-only.yaml -O
sleep 2

# See https://docs.projectcalico.org/v3.3/getting-started/kubernetes/installation/flannel
echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in calico-policy-only.yaml"
POD_CIDR="192.168.0.0/16"
sed -i -e "s?10.244.0.0/16?$POD_CIDR?g" calico-policy-only.yaml
sleep 2

echo "*** $(date) *** Apply calico-policy-only.yaml"
kubectl apply -f calico-policy-only.yaml
sleep 2
