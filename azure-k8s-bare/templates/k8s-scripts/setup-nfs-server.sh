#!/bin/bash
source ~/scripts/banner.sh

EXPORT_DIRECTORY=/datadrive/export/data
K8S_SUBNET=${1}

banner "setup-nfs.sh" "Make directories ${EXPORT_DIRECTORY}"
sudo mkdir -p ${EXPORT_DIRECTORY}

banner "setup-nfs.sh" "Mount binding ${DATA_DIRECTORY} to ${EXPORT_DIRECTORY}"
parentdir="$(dirname "$EXPORT_DIRECTORY")"
sudo chmod 777 ${EXPORT_DIRECTORY}
sudo chmod 777 $parentdir

banner "setup-nfs.sh" "Appending localhost and Kubernetes workers ${node} to exports configuration file"
for node in ${worker_nodes}
do
    echo "/datadrive/export        ${node}(rw,async,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports
done
echo "/datadrive/export        localhost(rw,async,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports

banner "setup-nfs.sh" "Restart NFS service"
sudo nohup service nfs-kernel-server restart
