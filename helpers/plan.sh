#!/usr/bin/env bash
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