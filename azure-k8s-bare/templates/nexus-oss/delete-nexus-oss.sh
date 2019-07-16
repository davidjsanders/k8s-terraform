#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/nexus-oss/load-nexus-oss.sh
# Environments:   all
# Purpose:        Bash shell script to delete any yaml files found in
#                 the nexus-oss sub-directory. This removes the
#                 NFS provisioner and sets the default storage class
#                 to none.
#
# Created on:     15 July 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 15 Jul 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "load-nexus-oss.sh" "Deleting NFS Provisioner"
yaml_files=$(ls -r1 ~/scripts/nexus-oss/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Delete yaml for: $file"
    kubectl delete -f $file
    if [ "$?" != "0" ]; then echo "Skipping $file!"; fi
    echo
done
echo

echo "Done."
echo
