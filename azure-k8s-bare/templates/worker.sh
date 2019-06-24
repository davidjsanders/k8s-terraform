#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/worker.sh
# Environments:   all
# Purpose:        The collection of steps and sequences required for
#                 setting up the worker node(s).
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
banner "worker.sh" "Perform configuration steps for worker(s)"

# Define the scripts that need to be executed to setup a worker
# node; Note the IFS is set to ;
scripts="/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/swap-off.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-nfs-common.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-jq.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/setup-nfs-client.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-docker.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/google-keys.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/install-k8s.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/hold.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts";/home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"

# Execute each script defined above
banner "worker.sh" "Executing Worker scripts"
IFS=$";"
for script in $scripts
do
    echo "source $script"
    source $script
done
IFS=$" "

# Copy the Docker daemon to the correct location
banner "worker.sh" "Executing Master scripts"
sudo cp /home/${admin}/scripts/registry/daemon.json /etc/docker/daemon.json

# Make sure the master is ready before proceeding. Currently, this
# simply executes a pwd command on the master BUT will be changed to
# perform a proper kubectl check.
banner "worker.sh" "Check master has rebooted"
while true
do
#    command="kubectl get nodes -o wide >/dev/null 2>&1 ; echo $?"
#    if [ "$check" != "0" ]

    command="pwd"
    check=$(ssh -o ConnectTimeout=10 ${admin}@k8s-master $${command})
    if [ "$check" != "/home/${admin}" ]
    then
        echo "Waiting for master. Sleeping 10s"
        sleep 10
    else
        echo "Master is reachable."
        break
    fi
done

# Now the master has been verified as ready, execute the join script
# the master provided.
banner "worker.sh" "Execute kubeadm_join_cmd.sh script"
sudo /home/${admin}/kubeadm_join_cmd.sh

# Copy the hostname.done file to the jumpbox to signify the worker
# has completed.
banner "worker.sh" "Copy done files to Jumpbox"
IFS=$" "
ssh -i ~/.ssh/azure_pk ${admin}@k8s-jumpbox "touch ~/$(hostname).done"

echo "*** $(date) *** DONE"
