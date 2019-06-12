echo "*** $(date) *** Get calico policy only (v3.7)"
curl https://docs.projectcalico.org/v3.7/manifests/calico-policy-only.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in calico-policy-only.yaml"
sed -i -e "s?192.168.0.0/16?192.168.0.0/16?g" calico-policy-only.yaml
sleep 2

echo "*** $(date) *** Apply calico-policy-only.yaml"
kubectl apply -f calico-policy-only.yaml
sleep 2
