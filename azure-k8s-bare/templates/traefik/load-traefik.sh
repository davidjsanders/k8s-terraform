#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/load-traefik.sh
# Environments:   all
# Purpose:        Bash shell script to apply any yaml files found in
#                 the traefik sub-directory.
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
# 26 Aug 2019  | David Sanders               | Re-factor traefik to
#              |                             | include basic auth
#              |                             | and TLS.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

yaml_files=$(ls -1 ~/scripts/traefik/[0-9]*.yaml)
for file in $yaml_files
do
    echo "Applying yaml for: $file"
    sed '
      s/\${domain_name}/'"${domain_name}"'/g;
      s/\${auth_file}/'"${auth_file}"'/g;
    ' $file | kubectl apply -f -
done
echo "Done."
echo
