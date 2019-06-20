#!/bin/bash
source ~/scripts/banner.sh
banner "install-k8s.sh" "apt-get install kubeadm, kubelet, kubectl - All 1.14.1-00"
sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -o Dpkg::Options::="--force-confold" \
  -q \
  --yes \
  install \
    kubeadm=1.14.3-00 \
    kubelet=1.14.3-00 \
    kubectl=1.14.3-00

sleep 2