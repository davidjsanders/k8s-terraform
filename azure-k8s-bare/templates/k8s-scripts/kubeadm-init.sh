#!/bin/bash
source ~/scripts/banner.sh
banner "kubeadm-init.sh" "Perform kubeadm init"

echo "*** $(date) *** kubeadm init"
sudo kubeadm init --kubernetes-version 1.14.1 --pod-network-cidr 192.168.0.0/16
