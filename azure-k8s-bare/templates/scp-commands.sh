#!/bin/bash
targets="${copy_targets}"
for target in $$targets
do
    echo "Copying files to $${target}"

    echo "Copying Azure Keys"
    scp -r -i ~/.ssh/azure_pk \
        ~/.ssh/azure_pk* \
        $${target}:~/.ssh/

    echo "Copying SSH config"
    scp -r -i ~/.ssh/azure_pk \
        ~/.ssh/config \
        $${target}:~/.ssh/

    echo "Copying hosts"
    scp -r -i ~/.ssh/azure_pk \
        ~/hosts \
        $${target}:~/hosts

    echo "Copying Scripts"
    scp -r -i ~/.ssh/azure_pk \
        ~/scripts \
        $${target}:~/
done
echo "Done."
