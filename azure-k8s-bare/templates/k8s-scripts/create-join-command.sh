#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/create-join-command.sh
# Environments:   all
# Purpose:        Get the join command and token from kubectl and
#                 save it to a file (kubeadm_join_cmd.sh) that can
#                 be copied to workers and executed to join the cluster
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
banner "create-join-command.sh" "Create the token and save as a join command"

echo "*** $(date) *** Create kubeadm_join_cmd.sh"
kubeadm token create --print-join-command >> kubeadm_join_cmd.sh
sleep 2

echo "*** $(date) *** Change kubeadm_join_cmd.sh to executable"
chmod +x kubeadm_join_cmd.sh
