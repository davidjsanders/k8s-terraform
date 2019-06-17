#!/bin/bash
source ~/scripts/banner.sh
banner "worker.sh" "Perform configuration steps for worker(s)"

scripts="/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/swap-off.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-docker.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/google-keys.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-k8s.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"

banner "worker.sh" "Executing Worker scripts"
for script in $scripts
do
    source $script
done

banner "worker.sh" "Execute kubeadm_join_cmd.sh script"
sudo /home/${admin}/kubeadm_join_cmd.sh

banner "worker.sh" "Copy done files to worker"
IFS=$" "
for worker in $workers
do
    ssh -i ~/.ssh/azure_pk ${admin}@k8s-jumpbox "touch ~/$(hostname).done"
done

echo "*** $(date) *** DONE"
