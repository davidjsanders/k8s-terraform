#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/setup-nfs-server.sh
# Environments:   all
# Purpose:        Setup the NFS Server and serve the /datadrive/export/
#                 from persistent storage and create entries in 
#                 /etc/exports for the worker nodes.
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

EXPORT_DIRECTORY=/datadrive/export
EXPORT_DIRECTORY_2=/datadrive/nexus
worker_nodes="${workers}"

banner "setup-nfs-server.sh" "Make directories $${EXPORT_DIRECTORY}"
sudo mkdir -p $${EXPORT_DIRECTORY}
sudo mkdir -p $${EXPORT_DIRECTORY_2}

banner "setup-nfs-server.sh" "chmod $${EXPORT_DIRECTORY}"
parentdir="$$(dirname "$$EXPORT_DIRECTORY")"
#sudo chmod -R 777 $${EXPORT_DIRECTORY}
#sudo chown -R nobody:nogroup $${EXPORT_DIRECTORY}
#sudo chmod -R 777 $$parentdir

banner "setup-nfs-server.sh" "chmod $${EXPORT_DIRECTORY_2}"
parentdir="$$(dirname "$$EXPORT_DIRECTORY_2")"
#sudo chmod -R 777 $${EXPORT_DIRECTORY_2}
#sudo chown -R nobody:nogroup $${EXPORT_DIRECTORY_2}
#sudo chmod -R 777 $$parentdir

banner "setup-nfs-server.sh" "Appending localhost and Kubernetes workers $${node} to exports configuration file"
IFS=$" "
for node in $${worker_nodes}
do
    echo "$EXPORT_DIRECTORY        $${node}(rw,async,no_root_squash,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports
    echo "$EXPORT_DIRECTORY_2         $${node}(rw,async,no_root_squash,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports
done
echo "$EXPORT_DIRECTORY        ${masters}(rw,async,no_root_squash,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports
echo "$EXPORT_DIRECTORY_2        ${masters}(rw,async,no_root_squash,insecure,fsid=0,crossmnt,no_subtree_check)" | sudo tee -a /etc/exports

banner "setup-nfs.sh" "Restart NFS service"
sudo service nfs-kernel-server restart
