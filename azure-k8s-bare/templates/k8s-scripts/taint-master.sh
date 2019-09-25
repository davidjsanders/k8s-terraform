#!/bin/bash
# -------------------------------------------------------------------
# DEPRECATED - DO NOT USE
# -------------------------------------------------------------------

source ~/scripts/banner.sh

banner "taint-master.sh" "Remove taints from master to enable scheduling"

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
