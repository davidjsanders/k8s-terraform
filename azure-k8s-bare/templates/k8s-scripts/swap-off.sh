source ~/scripts/banner.sh
banner "swap-off.sh" "Disable swap during installation of k8s and Docker"

echo "*** $(date) *** swap off"
sudo swapoff -a
sleep 2
