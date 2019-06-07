#!/bin/bash
echo "*** $(date) *** add kubernetes to apt sources"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sleep 2

echo "*** $(date) *** curl and add Google apt key"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sleep 2
