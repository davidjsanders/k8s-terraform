#!/usr/bin/env bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      helpers/init.sh
# Environments:   n/a
# Purpose:        Helper script to wrap the commands and arguments
#                 around terraform init.
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

#
# Validate args
#
if [ ! -f targets/beconf.tfvars ]; then
    echo "Error: No beconf.tfvars file was found in the targets directory"
    exit 1
fi
#
start_date=$(date)
echo ""
echo "Starting tf initat: "${start_date}
echo
echo "command: terraform init -backend-config=targets/beconf.tfvars"
echo
terraform init -backend-config=targets/beconf.tfvars
end_date=$(date)
echo
echo "Init started at   : "${start_date}
echo "Init completed at : "${end_date}
echo