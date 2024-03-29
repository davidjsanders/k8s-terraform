#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/kubeadm-init.sh
# Environments:   all
# Purpose:        Initialize the k8s master node at 1.14.3 and set
#                 the CIDR block to be 192.168.0.0/16
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
# 10 Jul 2019  | David Sanders               | Use kubeadm config
#              |                             | file. Initially, set
#              |                             | all values in this
#              |                             | scipt; later, this will
#              |                             | be changed to tf vars.
# -------------------------------------------------------------------

# Reference:
# Klevensky, K., 2019, Kubernetes by kubeadm config yamls [ONLINE] 
# Available at: https://medium.com/@kosta709/kubernetes-by-kubeadm-config-yamls-94e2ee11244
# Accessed on: 11 Jul 2019

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

current_dir=$(pwd)
sudo mkdir -p /root/kubeadm
sudo cp ~/scripts/k8s-scripts/kubeadm.config.yaml /root/kubeadm/kubeadm.config.yaml
sudo chmod 0600 /root/kubeadm/kubeadm.config.yaml

banner "kubeadm-init.sh" "Prepare configuration"
KUBEADM_CONFIG_FILE="/root/kubeadm/kubeadm.config.yaml"
KUBEADM_API=kubeadm.k8s.io
KUBEADM_API_VERSION=v1beta1
KUBEADM_TOKEN=$(kubeadm token generate)
KUBEADM_API_ADVERTISE_IP=10.70.1.6
KUBEADM_CERT_DIR="\/etc\/kubernetes\/pki"
KUBEADM_CLUSTER_NAME=kubernetes
KUBEADM_POD_SUBNET="192.168.0.0\/16"
KUBEADM_SERVICE_SUBNET="10.96.0.0\/12"
KUBEADM_K8S_VERSION=v1.14.3

banner "kubeadm-init.sh" "Substitute kubeadm config file values with sed"
sudo sed -i \
    's/\${KUBEADM_API}/'${KUBEADM_API}'/g;
     s/\${KUBEADM_API_VERSION}/'${KUBEADM_API_VERSION}'/g;
     s/\${KUBEADM_TOKEN}/'${KUBEADM_TOKEN}'/g;
     s/\${KUBEADM_API_ADVERTISE_IP}/'${KUBEADM_API_ADDVERTISE_IP}'/g;
     s/\${KUBEADM_CERT_DIR}/'${KUBEADM_CERT_DIR}'/g;
     s/\${KUBEADM_CLUSTER_NAME}/'${KUBEADM_CLUSTER_NAME}'/g;
     s/\${KUBEADM_POD_SUBNET}/'${KUBEADM_POD_SUBNET}'/g;
     s/\${KUBEADM_SERVICE_SUBNET}/'${KUBEADM_SERVICE_SUBNET}'/g;
     s/\${KUBEADM_K8S_VERSION}/'${KUBEADM_K8S_VERSION}'/g' \
    $KUBEADM_CONFIG_FILE
ret_stat="$?"
if [ "$ret_stat" != "0" ]
then
    banner "kubeadm-init.sh" "ERROR! Error substituting kubeadm config; exiting"
    exit 1
fi

banner "kubeadm-init.sh" "Perform kubeadm init"

echo "*** $(date) *** kubeadm init"
sudo kubeadm init \
    --config=$KUBEADM_CONFIG_FILE
