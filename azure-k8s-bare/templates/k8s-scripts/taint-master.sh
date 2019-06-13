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
