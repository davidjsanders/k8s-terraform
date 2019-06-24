#!/usr/bin/env bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      helpers/destroy.sh
# Environments:   n/a
# Purpose:        Helper script to wrap the commands and arguments
#                 around terraform destroy.
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
if [[ "$2x" == "x" ]] || [[ "$2x" != "--forcex" ]]; then
  echo ""
  echo "Starting tf destroy on $1 at: "${start_date}
  echo "You have 10 seconds to abort (control-C/^C) before execution."
  echo
  echo -n "Sleeping to allow cancellation: "
  for i in `seq 1 10`; do echo -n $((11 - i))"..."; sleep 1; done
  echo
  echo "Proceeding"
  echo
fi
terraform destroy \
  -var-file=targets/$1.tfvars \
  -var-file=targets/credentials.secret \
  -force
end_date=$(date)
echo
echo "Apply started at   : "${start_date}
echo "Apply completed at : "${end_date}
echo