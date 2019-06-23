#!/bin/bash
source ~/scripts/banner.sh
banner "worker.sh" "Perform configuration steps for worker(s)"

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

banner "worker.sh" "Executing Worker scripts"
IFS=$";"
for script in $scripts
do
    echo "source $script"
    source $script
done
IFS=$" "

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

banner "worker.sh" "Execute kubeadm_join_cmd.sh script"
sudo /home/${admin}/kubeadm_join_cmd.sh

banner "worker.sh" "Copy done files to Jumpbox"
IFS=$" "
ssh -i ~/.ssh/azure_pk ${admin}@k8s-jumpbox "touch ~/$(hostname).done"

echo "*** $(date) *** DONE"
