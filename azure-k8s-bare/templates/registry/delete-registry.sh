#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/load-registry.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the registry sub-directory.
#
# Created on:     26 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 26 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

yaml_files=$(ls -r1 ~/registry/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Delete yaml for: $file"
    kubectl delete -f $file
    echo
done
echo "Done."
echo
