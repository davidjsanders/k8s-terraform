echo "*** $(date) *** make .kube directory"
mkdir -p $HOME/.kube
sleep 2

echo "*** $(date) *** copy config"
sudo cp -if /etc/kubernetes/admin.conf $HOME/.kube/config
sleep 2

echo "*** $(date) *** change config owner to $(id -u):$(id -g)"
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 2
