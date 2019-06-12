#!/bin/bash
targets="${copy_targets}"
for target in $$targets
do
    echo "Copying files to $${target}"

    echo "Copying Azure Public Key"
    scp -r -i ~/.ssh/azure_pk \
        ~/scripts \
        $${target}:~/
done
echo "Done."
