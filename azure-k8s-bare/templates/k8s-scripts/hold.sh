#!/bin/bash
source ~/scripts/banner.sh
banner "install-k8s.sh" "apt-mark hold at 1.14.1-00"
sudo DEBIAN_FRONTEND=noninteractive \
  apt-mark hold \
    docker \
    kubeadm \
    kubelet \
    kubectl
