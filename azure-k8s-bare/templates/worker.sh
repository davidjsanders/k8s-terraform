#!/bin/bash
echo "*** $(date) *** apt-get update"
sudo apt-get update
sleep 2

echo "*** $(date) *** apt-get upgrade --yes"
sudo apt-get upgrade --yes
sleep 2

echo "*** $(date) *** apt-get dist-update --yes"
sudo apt-get dist-upgrade --yes
sleep 2

echo "*** $(date) *** swap off"
sudo swapoff -a
sleep 2

echo "*** $(date) *** apt-get install -y docker.io"
sudo apt-get install -y docker.io
sleep 2

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sudo apt-get update
sudo apt-get install -y kubeadm=1.14.1-00 kubelet=1.14.1-00 kubectl=1.14.1-00
