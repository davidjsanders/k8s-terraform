banner "label-workers.sh" "Label worker nodes"

master=(${masters})
do_ssh \
    "Executing: kubectl label nodes role=worker -l node-role.kubernetes.io/master!=" \
    $admin@${master[0]} \
    "kubectl label nodes role=worker -l node-role.kubernetes.io/master!="
