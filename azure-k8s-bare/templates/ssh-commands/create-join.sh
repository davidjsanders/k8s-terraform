# After the master script is completed, a kubeadm_join_cmd is
# created to allow other nodes to join. This script is now copied
# to each node.
banner "ssh-commands.sh" "Copy kubeadm_join_cmd.sh to all workers"
IFS=$" "
for worker in $$workers
do
    do_scp \
        "Copy kubeadm_join_cmd.sh to $$worker" \
        k8s-master:/home/${admin}/kubeadm_join_cmd.sh \
        $$worker:/home/${admin}/kubeadm_join_cmd.sh
done
