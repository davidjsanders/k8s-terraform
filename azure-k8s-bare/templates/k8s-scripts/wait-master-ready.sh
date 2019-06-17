source ~/scripts/banner.sh
banner "wait-master-ready.sh" "Wait for the current Master node to become ready"

echo "*** $(date) *** Wait for master to become ready"
while [ "$(kubectl get nodes -o wide | grep NotReady)X" != "X" ]
do
    echo "*** $(date) *** Waiting for master to become ready"
    sleep 10
done
