# While the master is rebooting, the workers are executed 
# "In Parallel" using nohup and background tasks to setup the
# Docker and k8s packages. The workers *WILL* wait for the
# master to reboot before tryng to join the cluster.
#
# In an Emergency
# ---------------
# If for some reason the master doesn't come up, the easiest way
# to abort so the cluster can be destroyed (DON'T rerun the 
# provisioner!), is to ssh into the jumpbox and `touch` worker1.done
# through workern.done - this 'fools' the script into thinking all
# workers are done.
banner "ssh-commands.sh" "Execute ssh commands on all workers"
worker_commands="~/scripts/worker.sh"
IFS=$" "
for worker in $$workers
do
    do_ssh_nohup \
        "Executing worker.sh" \
        ${admin}@$${worker} \
        "~/scripts/worker.sh"
done
