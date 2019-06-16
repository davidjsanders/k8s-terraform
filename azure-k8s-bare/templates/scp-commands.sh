#!/bin/bash
source /home/${admin}/scripts/banner.sh
source /home/${admin}/scripts/do-scp.sh

banner "scp-commands.sh" "scp (secure copy)"
targets="${copy_targets}"
for target in $$targets
do
    echo "Copying files to $${target}"

    do_scp \
        "Copying Azure Private Key" \
        ~/.ssh/azure_pk \
        $${target}:~/.ssh/

    do_scp \
        "Copying Azure Public Key" \
        ~/.ssh/azure_pk.pub \
        $${target}:~/.ssh/

    do_scp \
        "Copying SSH config" \
        ~/.ssh/config \
        $${target}:~/.ssh/

    do_scp \
        "Copying hosts" \
        ~/hosts \
        $${target}:~/hosts

    do_scp \
        "Copying Scripts" \
        ~/scripts \
        $${target}:~/
done
banner "DONE scp-commands.sh" "scp (secure copy)"
