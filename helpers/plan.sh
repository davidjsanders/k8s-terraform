#!/usr/bin/env bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      helpers/plan.sh
# Environments:   n/a
# Purpose:        Helper script to wrap the commands and arguments
#                 around terraform plan.
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
#
start_date=$(date)
echo ""
echo "Starting tf plan on $1 at: "${start_date}
echo
echo "command: terraform plan -input=false -out=targets/$1-run -var-file=targets/$1.tfvars -var-file=targets/credentials.secret"
echo
terraform plan \
  -input=false \
  -out=targets/$1-run \
  -var-file=targets/$1.tfvars \
  -var-file=targets/credentials.secret
end_date=$(date)
echo
echo "Plan started at   : "${start_date}
echo "Plan completed at : "${end_date}
echo