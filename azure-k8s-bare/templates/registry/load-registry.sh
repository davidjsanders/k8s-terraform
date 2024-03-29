#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/load-registry.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the registry sub-directory.
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
# 15 Jul 2019  | David Sanders               | Add sleep period between
#              |                             | each yaml apply.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

sleep_period=5

yaml_files=$(ls -1 ~/registry/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    kubectl apply -f $file
    echo
    sleep $sleep_period
done
echo "Done."
echo
