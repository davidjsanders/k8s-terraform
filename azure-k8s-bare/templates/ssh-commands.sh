#!/bin/bash
masters="${masters}"
workers="${workers}"
for target in $$masters $$workers
do
    echo "Executing common files on master at ${admin}@$${target}"
    ssh -i ~/.ssh/azure_pk \
        ${admin}@$${target} \
        chmod +x ~/scripts/master.sh ~/scripts/worker.sh ~/scripts/scp-commands.sh ~/scripts/ssh-commands.sh
done

for master in $$masters
do
    echo "Executing scripts on master at $${master}"

    echo "Execute master.sh"
    ssh -i ~/.ssh/azure_pk \
        ${admin}@$${master} \
        "~/scripts/master.sh"
done

for worker in $$workers
do
    echo "Executing scripts on worker at $${worker}"

    echo "Execute worker.sh"
    ssh -i ~/.ssh/azure_pk \
        ${admin}@$${worker} \
        "~/scripts/worker.sh"

    echo "Execute kubeadm_join_cmd.sh"
    ssh -i ~/.ssh/azure_pk \
        ${admin}@$${worker} \
        "sudo ~/scripts/kubeadm_join_cmd.sh"
done

for master in $$masters
do
    echo "Executing final scripts on master at $${master}"

    echo "Execute load-traefik.sh"
    ssh -i ~/.ssh/azure_pk \
        ${admin}@$${master} \
        "~/scripts/traefik/load-traefik.sh"
done
