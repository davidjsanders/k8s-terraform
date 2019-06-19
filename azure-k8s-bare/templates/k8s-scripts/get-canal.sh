source ~/scripts/banner.sh
banner "get-canal.sh" "Download, setup and install Canal"

echo "*** $(date) *** Get canal"
curl https://docs.projectcalico.org/v3.7/manifests/canal.yaml -O
sleep 2

echo "*** $(date) *** Change IP Cidr to 192.168.0.0/16 in canal.yaml"
POD_CIDR="192.168.0.0/16"
sed -i -e "s?10.244.0.0/16?$POD_CIDR?g" canal.yaml
#sed -i -e "s?10.244.0.0/16?192.168.0.0/16?g" canal.yaml
sleep 2

echo "*** $(date) *** Apply canal.yaml"
kubectl apply -f canal.yaml
sleep 2
