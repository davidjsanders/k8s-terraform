#!/bin/bash
scripts="/home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/swap-off.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-docker.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-google-k8s-keys.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/install-k8s.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/kubeadm-init.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/kube-config.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/get-calico.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/get-canal.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/create-join-command.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/wait-master-ready.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/autocomplete.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-updates.sh"
scripts=$scripts" /home/${admin}/scripts/k8s-scripts/apt-upgrade.sh"

echo "Executing Master scripts"
for script in $scripts
do
    source $script
done

echo "*** $(date) *** DONE"