#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/load-cowbull.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the cowbull sub-directory.
#
# Created on:     24 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 24 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 26 Jun 2019  | David Sanders               | Add space between each
#              |                             | yaml apply.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

yaml_files=$(ls -r1 ~/scripts/local-storage/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    kubectl delete -f $file
    echo
done
echo "Done."
echo
