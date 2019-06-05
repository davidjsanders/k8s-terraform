#!/usr/bin/env bash
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
terraform apply -input=false targets/$1-run
end_date=$(date)
echo
echo "Apply started at   : "${start_date}
echo "Apply completed at : "${end_date}
echo