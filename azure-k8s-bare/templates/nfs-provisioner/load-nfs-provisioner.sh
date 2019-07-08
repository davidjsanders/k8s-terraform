#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/nfs-provisioner/load-nfs-provisioner.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the nfs-provisioner sub-directory. This installs an
#                 NFS provisioner and sets the default storage class
#                 for the cluster to the provisioner.
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

banner "load-nfs-provisioner.sh" "Apply NFS Provisioner"
yaml_files=$(ls -1 ~/scripts/nfs-provisioner/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    kubectl apply -f $file
    if [ "$?" != "0" ]; then echo "Error applying NFS provisioner!"; exit 1; fi
    echo
done
if [ "$?" != "0" ]; then echo "Error applying NFS provisioner!"; exit 1; fi

banner "load-nfs-provisioner.sh" "Set default storage class"
kubectl patch \
    storageclass example-nfs \
    -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
if [ "$?" != "0" ]; then echo "Error applying NFS provisioner!"; exit 1; fi
echo

echo "Done."
echo