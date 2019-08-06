#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-jenkins
# Submodule:      banner.sh
# Environments:   all
# Purpose:        Define a log_banner function to be used anywhere it is
#                 sourced
#
# Created on:     30 July 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 30 Jul 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

function log_banner() {
    short_banner "***********************************************"
    short_banner "* HOST   : $(hostname)"
    short_banner "* SCRIPT : ${1}"
    short_banner "***********************************************"
    short_banner "* ACTION : ${2}"
    short_banner "***********************************************"
    echo
}

function short_banner() {
    now=$(date +"%m-%d-%Y-%H:%M:%S")
    echo "$now : ${1}"
}