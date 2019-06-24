#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/scp-commands.sh
# Environments:   all
# Purpose:        The collection of steps and sequences required for
#                 copying setup files from the jumpbox to the nodes.
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

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh
source /home/${admin}/scripts/do-scp.sh
source /home/${admin}/scripts/do-scp-recursive.sh

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

    do_scp_recursive \
        "Copying Scripts" \
        ~/scripts \
        $${target}:~/
done
banner "DONE scp-commands.sh" "scp (secure copy)"
