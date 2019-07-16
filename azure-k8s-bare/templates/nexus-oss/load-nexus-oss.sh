#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/nexus-oss/load-nexus-oss.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the nexus-oss sub-directory. This installs an
#                 Nexus OSS and sets the default storage class
#                 for the cluster to the provisioner.
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

if [ -z "${LBIP+x}" ]
then
    echo "ERROR: The environment variable LBIP (Load Balancer IP) must be set!"
    exit 1
fi

banner "load-nexus-oss.sh" "Apply NFS Provisioner"
yaml_files=$(ls -1 ~/scripts/nexus-oss/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    kubectl apply -f $file
    if [ "$?" != "0" ]; then echo "Error applying Nexus OSS!"; exit 1; fi
    echo
done

echo
echo "Applying Ingress"
echo
sed 's/\${LBIP}/'"$LBIP"'/g' ~/scripts/nexus-oss/ingress.yaml.env | kubectl apply -f -
if [ "$?" != "0" ]; then echo "Error applying Nexus OSS!"; exit 1; fi
echo


echo "Done."
echo
