source ~/scripts/banner.sh
banner "create-join-command.sh" "Create the token and save as a join command"

echo "*** $(date) *** Create kubeadm_join_cmd.sh"
kubeadm token create --print-join-command >> kubeadm_join_cmd.sh
sleep 2

echo "*** $(date) *** Change kubeadm_join_cmd.sh to executable"
chmod +x kubeadm_join_cmd.sh
