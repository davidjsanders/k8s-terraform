#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/banner.sh
# Environments:   all
# Purpose:        Define a banner function to be used anywhere it is
#                 sourced
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

function banner() {
    echo 
    echo "***********************************************"
    echo "* HOST   : $(hostname)"
    echo "* SCRIPT : ${1}"
    echo "***********************************************"
    echo "* ACTION : ${2}"
    echo "***********************************************"
    echo 
}