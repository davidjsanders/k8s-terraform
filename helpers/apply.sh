#!/usr/bin/env bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      helpers/apply.sh
# Environments:   n/a
# Purpose:        Helper script to wrap the commands and arguments
#                 around terraform apply.
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
. ../helpers/error-checking
if [ ! -f targets/$1-run ]; then
    echo "Error: The target out file targets/$1-run was not found; have you run plan?"
    exit 1
fi
#
start_date=$(date)
echo ""
echo "Starting tf apply on $1 at: "${start_date}
echo
echo "command: terraform apply -input=false targets/$1-run"
echo
terraform apply -input=false targets/$1-run
end_date=$(date)
echo
echo "Apply started at   : "${start_date}
echo "Apply completed at : "${end_date}
echo