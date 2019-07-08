#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/nfs-provisioner/load-nfs-provisioner.sh
# Environments:   all
# Purpose:        Bash shell script to delete any yaml files found in
#                 the nfs-provisioner sub-directory. This removes the
#                 NFS provisioner and sets the default storage class
#                 to none.
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

banner "delete-nfs-provisioner.sh" "Remove default storage class"
kubectl patch \
    storageclass example-nfs \
    -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
if [ "$?" != "0" ]; then echo "Error applying NFS provisioner!"; exit 1; fi
echo

banner "load-nfs-provisioner.sh" "Deleting NFS Provisioner"
yaml_files=$(ls -r1 /datadrive/azadmin/nfs-provisioner/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Delete yaml for: $file"
    kubectl delete -f $file
    if [ "$?" != "0" ]; then echo "Error applying NFS provisioner!"; exit 1; fi
    echo
done
echo

echo "Done."
echo