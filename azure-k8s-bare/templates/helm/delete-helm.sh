#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/helm/load-helm.sh
# Environments:   all
# Purpose:        Bash shell script to remove Helm from the currently
#                 selected cluster (including service account) but
#                 not the executables.
#
# Created on:     07 July 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 07 Jul 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "load-helm.sh" "Perform a HELM reset in cluster"
helm reset
if [ "$?" != "0" ]; then echo "Error performing helm reset!"; exit 1; fi

banner "load-helm.sh" "Remove the HELM RBAC configuration"
kubectl delete -f /home/${admin}/scripts/helm/helm-rbac-role.yaml
if [ "$?" != "0" ]; then echo "Error removing helm rbac!"; exit 1; fi
