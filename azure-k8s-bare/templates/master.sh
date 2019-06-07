#!/bin/bash
source k8s-scripts/apt-updates.sh
source k8s-scripts/apt-upgrade.sh
source k8s-scripts/swap-off.sh
source k8s-scripts/install-docker.sh
source k8s-scripts/apt-google-k8s-keys.sh
source k8s-scripts/apt-updates.sh
source k8s-scripts/install-k8s.sh

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

echo "*** $(date) *** Apply calico-policy-only.yaml"
kubectl apply -f calico-policy-only.yaml
sleep 2

echo "*** $(date) *** Apply canal.yaml"
kubectl apply -f canal.yaml
sleep 2

echo "*** $(date) *** Create kubeadm_join_cmd.sh"
kubeadm token create --print-join-command >> kubeadm_join_cmd.sh
sleep 2

echo "*** $(date) *** Change kubeadm_join_cmd.sh to executable"
chmod +x kubeadm_join_cmd.sh

echo "*** $(date) *** Wait for master to become ready"
while [ "$(kubectl get nodes -o wide | grep NotReady)X" != "X" ]
do
    echo "*** $(date) *** Waiting for master to become ready"
    sleep 10
done

echo "*** $(date) *** taint master node"
sleep 10
kubectl taint \
    nodes \
    --all=true \
    node-role.kubernetes.io/master-
sleep 2

echo "*** $(date) *** Show taints"
kubectl describe nodes | grep Taint
sleep 2

echo "*** $(date) *** enable autocompletion in shell"
echo "source <(kubectl completion bash)" >> ~/.bashrc
sleep 2

echo "*** $(date) *** enable autocompletion for current session"
source <(kubectl completion bash)
sleep 2

echo "*** $(date) *** DONE"