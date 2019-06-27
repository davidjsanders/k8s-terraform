#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/master.sh
# Environments:   all
# Purpose:        The collection of steps and sequences required to
#                 setup the k8s master.
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
# 23 Jun 2019  | David Sanders               | Add private registry.
# -------------------------------------------------------------------
# 27 Jun 2019  | David Sanders               | Add docker-compose to
#              |                             | master.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "master.sh" "Perform configuration steps for master(s)"

# Define the scripts that should be called by this scheduler.
# Note the IFS is set to ;
scripts="/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/swap-off.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/fstab-datadrive.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-nfs-server.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-jq.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/setup-nfs-server.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-docker.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-docker-compose.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-google-k8s-keys.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-k8s.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/hold.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/kubeadm-init.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/kube-config.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/get-calico.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/get-canal.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/create-join-command.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/wait-master-ready.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/autocomplete.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"

# Loop through the list of scripts and source each one in 
# order. Note the IFS is ;
banner "master.sh" "Executing Master scripts"
IFS=$";"
for script in $scripts
do
    source $script
done
IFS=$" "

# Copy the Docker daemon to the correct location
banner "master.sh" "Copy daemon.json /etc/docker"
sudo cp /home/${admin}/registry/daemon.json-template /etc/docker/daemon.json

echo "*** $(date) *** DONE"