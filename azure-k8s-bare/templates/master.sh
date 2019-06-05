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

echo "*** $(date) *** systemctl enable docker"
sudo systemctl enable docker.service
sleep 2

echo "*** $(date) *** add kubernetes to apt sources"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sleep 2

echo "*** $(date) *** curl and add Google apt key"
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sleep 2

echo "*** $(date) *** apt-get update"
sudo apt-get update
sleep 2

echo "*** $(date) *** apt-get install kubeadm, kubelet, kubectl - All 1.14.1-00"
sudo apt-get install -y kubeadm=1.14.1-00 kubelet=1.14.1-00 kubectl=1.14.1-00
sleep 2

echo "*** $(date) *** kubeadm init"
sudo kubeadm init --kubernetes-version 1.14.1 --pod-network-cidr 192.168.0.0/16

echo "*** $(date) *** make .kube directory"
mkdir -p $HOME/.kube
sleep 2

echo "*** $(date) *** copy config"
sudo cp -if /etc/kubernetes/admin.conf $HOME/.kube/config
sleep 2

echo "*** $(date) *** change config owner to $(id -u):$(id -g)"
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 2

# echo "*** $(date) *** taint master node"
# sleep 10
# kubectl taint \
#     nodes \
#     --all=true \
#     node-role.kubernetes.io/master-
# sleep 2

# echo "*** $(date) *** Show taints"
# kubectl describe nodes | grep Taint
# sleep 2

echo "*** $(date) *** Wait for master to become ready"
while [ "$(kubectl get nodes -o wide | grep NotReady)X" != "X" ]
do
    echo "*** $(date) *** Waiting for master to become ready"
    sleep 20
done

echo "*** $(date) *** enable autocompletion in shell"
echo "source <(kubectl completion bash)" >> ~/.bashrc
sleep 2

echo "*** $(date) *** enable autocompletion for current session"
source <(kubectl completion bash)
sleep 2

echo "*** $(date) *** Get calico policy only (v3.7)"
curl https://docs.projectcalico.org/v3.7/manifests/calico-policy-only.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in calico-policy-only.yaml"
sed -i -e "s?192.168.0.0/16?192.168.0.0/16?g" calico-policy-only.yaml
sleep 2

echo "*** $(date) *** Get canal"
curl https://docs.projectcalico.org/v3.7/manifests/canal.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in canal.yaml"
sed -i -e "s?10.244.0.0/16?192.168.0.0/16?g" canal.yaml
sleep 2

echo "*** $(date) *** Create kubeadm_join_cmd.sh"
kubeadm token create --print-join-command >> kubeadm_join_cmd.sh
sleep 2

echo "*** $(date) *** Change kubeadm_join_cmd.sh to executable"
chmod +x kubeadm_join_cmd.sh

echo "*** $(date) *** DONE"