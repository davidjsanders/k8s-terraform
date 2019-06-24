#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/do_scp_recursive.sh
# Environments:   all
# Purpose:        Function to perform ssh with repetitive args
#                 included by default.
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

function do_ssh() {
    echo "${1}"
    ssh -i ~/.ssh/azure_pk ${2} "${3}"
}