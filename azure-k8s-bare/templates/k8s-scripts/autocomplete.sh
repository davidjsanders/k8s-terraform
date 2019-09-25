#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/autocomplete.sh
# Environments:   all
# Purpose:        Setup bash autocomplete for kubectl and write to
#                 the .bashrc file to ensure autocomplete at login 
#                 time
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
banner "autocomplete.sh" "Enable BASH kubectl autocompletion"

echo "*** $(date) *** enable autocompletion in shell"
echo "source <(kubectl completion bash)" >> ~/.bashrc
sleep 2

echo "*** $(date) *** enable autocompletion for current session"
source <(kubectl completion bash)
sleep 2
