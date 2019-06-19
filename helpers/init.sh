#!/usr/bin/env bash
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