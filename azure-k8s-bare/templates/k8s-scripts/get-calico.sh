source ~/scripts/banner.sh
banner "get-calico.sh" "Download, setup and install Calico (policy only)"

echo "*** $(date) *** Get calico policy only (v3.7)"
curl https://docs.projectcalico.org/v3.7/manifests/calico-policy-only.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in calico-policy-only.yaml"
POD_CIDR="192.168.0.0/16"
sed -i -e "s?10.244.0.0/16?$POD_CIDR?g" calico-policy-only.yaml
sleep 2

echo "*** $(date) *** Apply calico-policy-only.yaml"
kubectl apply -f calico-policy-only.yaml
sleep 2
