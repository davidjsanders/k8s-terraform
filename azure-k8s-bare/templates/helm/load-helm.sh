#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/helm/load-helm.sh
# Environments:   all
# Purpose:        Bash shell script to download Helm (2.14.1), copy
#                 the required files to /usr/local/bin, apply an
#                 RBAC role and install tiller with the service account.
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

banner "load-helm.sh" "Fetch & Install HELM executables"
current_dir=$(pwd)
mkdir -p /tmp/helm
cd /tmp/helm
wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz
tar -xvf helm-v2.14.1-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/
sudo cp linux-amd64/tiller /usr/local/bin/
cd $current_dir
rm -rf /tmp/helm

banner "load-helm.sh" "Prepare HELM RBAC controls"
kubectl apply -f /home/${admin}/scripts/helm/helm-rbac-role.yaml
if [ "$?" != "0" ]; then echo "Error applying helm rbac configuration!"; exit 1; fi

banner "load-helm.sh" "Install HELM into cluster"
helm init --service-account ${tiller_user} --history-max 200
if [ "$?" != "0" ]; then echo "Error performing helm init!"; exit 1; fi


