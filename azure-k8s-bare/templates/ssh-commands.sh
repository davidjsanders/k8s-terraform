#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/ssh-commands.sh
# Environments:   all
# Purpose:        The collection of steps and sequences required for
#                 executing ssh commands from the jumpbox to the
#                 cluster nodes.
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
# 24 Jun 2019  | David Sanders               | Add private registry.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh
source /home/${admin}/scripts/do-ssh.sh
source /home/${admin}/scripts/do-ssh-nohup.sh
source /home/${admin}/scripts/do-scp.sh

masters="${masters}"
workers="${workers}"

# Define the scripts that should be set to executable.
banner "ssh-commands.sh" "Set all scripts on all machines to be executable"
executable_scripts="/home/${admin}/scripts/traefik/load-traefik.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/registry/load-registry.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/master.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/worker.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/scp-commands.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/ssh-commands.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/registry/load-registry.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/registry/delete-registry.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/helm/load-helm.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/helm/delete-helm.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/nfs-provisioner/load-nfs-provisioner.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/nfs-provisioner/delete-nfs-provisioner.sh"

# Execute an ssh command on every node and set the executable
# flag on the scripts and setup the hosts file
IFS=$" "
for target in $$masters $$workers
do
    do_ssh \
        "Set scripts to be executable on $${target}" \
        ${admin}@$${target} \
        "chmod +x $${executable_scripts}"

    do_ssh \
        "Setup hosts file on $${target}" \
        ${admin}@$${target} \
        "cat /home/${admin}/hosts | sudo tee -a /etc/hosts"
done

# Define the commands that should be executed on the master. TODO: 
# These should probably ALL be in master.sh rather than split here
# and most in the other shell script.
banner "ssh-commands.sh" "Execute ssh commands on master"

# Make the mountpoint for the NFS drive
master_commands="sudo mkdir /datadrive"

# Mount the NFS drive
master_commands="$${master_commands};sudo mount /dev/sdc1 /datadrive"

# Change the ownership of *EVERYTHING* in the drive to the admin user
master_commands="$${master_commands};sudo chown -R ${admin} /datadrive/azadmin"

# Setup the hosts file
master_commands="$${master_commands};cat /home/${admin}/hosts | sudo tee -a /etc/hosts"

# Move the registry files from the scripts dir to the home dir
master_commands="$${master_commands};mv /home/${admin}/scripts/registry /home/${admin}/registry"

# Execute the steps required to setup a k8s master
master_commands="$${master_commands};~/scripts/master.sh"

# Execute the commands on every master
IFS=$" "
for master in $$masters
do
    IFS=$';'
    for command in $$master_commands
    do
        do_ssh \
            "Executing $${command}" \
            ${admin}@$${master} \
            $${command}
    done
done

# After the master script is completed, a kubeadm_join_cmd is
# created to allow other nodes to join. This script is now copied
# to each node.
banner "ssh-commands.sh" "Copy kubeadm_join_cmd.sh to all workers"
IFS=$" "
for worker in $$workers
do
    do_scp \
        "Copy kubeadm_join_cmd.sh to $$worker" \
        k8s-master:/home/${admin}/kubeadm_join_cmd.sh \
        $$worker:/home/${admin}/kubeadm_join_cmd.sh
done

# After copying the script, the master is rebooted.
banner "ssh-commands.sh" "Instruct masters to reboot"
IFS=$" "
for target in $$masters
do
    do_ssh \
        "Reboot node $${target}" \
        ${admin}@$${target} \
        "sudo reboot now"
done

# While the master is rebooting, the workers are executed 
# "In Parallel" using nohup and background tasks to setup the
# Docker and k8s packages. The workers *WILL* wait for the
# master to reboot before tryng to join the cluster.
#
# In an Emergency
# ---------------
# If for some reason the master doesn't come up, the easiest way
# to abort so the cluster can be destroyed (DON'T rerun the 
# provisioner!), is to ssh into the jumpbox and `touch` worker1.done
# through workern.done - this 'fools' the script into thinking all
# workers are done.
banner "ssh-commands.sh" "Execute ssh commands on all workers"
worker_commands="~/scripts/worker.sh"
IFS=$" "
for worker in $$workers
do
    do_ssh_nohup \
        "Executing worker.sh" \
        ${admin}@$${worker} \
        "~/scripts/worker.sh"
done

# The worker scripts are running in the background and this script
# now waits until each worker is completed. A worker signifies
# completion by copying a hostname.done file to the jumpbox. When
# the number of files matches the number of workers, the script
# proceeds.
banner "ssh-commands.sh" "Wait for workers to complete"
function show_state() {
    banner "ssh-commands.sh" "$1 - $2 done reports for $3 agents"
}
worker_array=(${workers})
sleep_time=30
IFS=$" "
while true
do
    files=$(ls -m *.done)
    done_files=(`echo $files`)

    echo "Done notices : $${#done_files[@]}"
    echo "Workers      : $${#worker_array[@]}"

    if [ "$${#done_files[@]}" == "$${#worker_array[@]}" ]
    then
        break;
    fi
    show_state "In progress" "$${#done_files[@]}"
    sleep $${sleep_time}
done
show_state "Completed" "$${#done_files[@]}"

# Reboot all of the workers
banner "ssh-commands.sh" "Reboot all workers"
IFS=$" "
for worker in $$workers
do
    do_ssh \
        "Executing $${command}" \
        ${admin}@$${worker} \
        "sudo reboot now"
done

# Load the collection of apps we want to apply to our new k8s
# cluster in advance of starting. There should really be a check
# here to make sure all the nodes are ready, although k8s should
# proceed okay.
scripts="/home/${admin}/scripts/traefik/load-traefik.sh"
scripts="$scripts;/home/${admin}/scripts/helm/load-helm.sh"

# Loop through the list of scripts and source each one in 
# order. Note the IFS is ;
banner "master.sh" "Loading kubernetes apps"
master=(${masters})
IFS=$";"
for script in $scripts
do
    do_ssh \
        "Execute $script" \
        ${admin}@$${master[0]} \
        "$${script}"
done
IFS=$" "

banner "DONE ssh-commands.sh" "Completed all commands on all machines"
IFS=$" "
