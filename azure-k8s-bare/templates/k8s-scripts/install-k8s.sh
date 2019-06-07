#!/bin/bash
echo "*** $(date) *** apt-get install kubeadm, kubelet, kubectl - All 1.14.1-00"
sudo apt-get install -y kubeadm=1.14.1-00 kubelet=1.14.1-00 kubectl=1.14.1-00
sleep 2
