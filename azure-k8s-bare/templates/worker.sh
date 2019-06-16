#!/bin/bash
scripts="/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/swap-off.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-docker.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/google-keys.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-k8s.sh"

echo "Executing Worker scripts"
for script in $scripts
do
    echo " "
    echo "****************************"
    echo "* Worker - Executing script: $script"
    echo "****************************"
    echo " "
    source $script
done

echo " "
echo "****************************"
echo "* Worker - Executing script: /home/${admin}/scripts/kubeadm_join_cmd.sh"
echo "****************************"
echo " "
sudo /home/${admin}/scripts/kubeadm_join_cmd.sh

echo "*** $(date) *** DONE"
