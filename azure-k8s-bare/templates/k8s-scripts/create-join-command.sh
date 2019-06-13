echo "*** $(date) *** Create kubeadm_join_cmd.sh"
kubeadm token create --print-join-command >> kubeadm_join_cmd.sh
sleep 2

echo "*** $(date) *** Change kubeadm_join_cmd.sh to executable"
chmod +x kubeadm_join_cmd.sh
