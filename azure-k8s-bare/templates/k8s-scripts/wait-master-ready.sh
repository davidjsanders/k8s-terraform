#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/wait-master-ready.sh
# Environments:   all
# Purpose:        Loop until the k8s master reports that it is ready.
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

banner "wait-master-ready.sh" "Wait for the current Master node to become ready"

echo "*** $(date) *** Wait for master to become ready"
while [ "$(kubectl get nodes -o wide | grep NotReady)X" != "X" ]
do
    echo "*** $(date) *** Waiting for master to become ready"
    sleep 10
done
