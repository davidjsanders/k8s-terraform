#!/bin/bash
source /home/${admin}/scripts/banner.sh
source /home/${admin}/scripts/do-ssh.sh
source /home/${admin}/scripts/do-scp.sh

masters="${masters}"
workers="${workers}"

banner "ssh-commands.sh" "Set all scripts on all machines to be executable"
executable_scripts="/home/${admin}/scripts/traefik/load-traefik.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/master.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/worker.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/scp-commands.sh"
executable_scripts="$executable_scripts /home/${admin}/scripts/ssh-commands.sh"
IFS=$" "
for target in $$masters $$workers
do
    do_ssh \
        "Set scripts to be executable on $${target}" \
        ${admin}@$${target} \
        "chmod +x $${executable_scripts}"
done

banner "ssh-commands.sh" "Execute ssh commands on master"
master_commands="sudo mkdir /datadrive"
master_commands="$${master_commands};sudo mount /dev/sdc1 /datadrive"
master_commands="$${master_commands};sudo chown -R ${admin} /datadrive/azadmin"
master_commands="$${master_commands};~/scripts/master.sh"
IFS=$" "
for master in $$masters
do
    IFS=$';'
    for command in master_commands
    do
        do_ssh \
            "Executing $${command}" \
            ${admin}@$${master} \
            $${command}
    done

    # do_ssh \
    #     "Mount /dev/sdc1 to /datadrive" \
    #     ${admin}@$${master} \
    #     "sudo mount /dev/sdc1 /datadrive"

    # do_ssh \
    #     "Ensure ownership of /datadrive/azadmin is set to ${admin}" \
    #     ${admin}@$${master} \
    #     "sudo chown -R ${admin} /datadrive/azadmin"

    # do_ssh \
    #     "Execute master.sh" \
    #     ${admin}@$${master} \
    #     "~/scripts/master.sh"
done

banner "ssh-commands.sh" "Copy kubeadm_join_cmd.sh to all workers"
IFS=$" "
for worker in $$workers
do
    do_scp \
        "Copy kubeadm_join_cmd.sh to $$worker" \
        k8s-master:/home/${admin}/scripts/kubeadm_join_cmd.sh \
        $$worker:/home/${admin}/scripts/kubeadm_join_cmd.sh
done

banner "ssh-commands.sh" "Execute ssh commands on all workers"
worker_commands="~/scripts/worker.sh"
IFS=$" "
for worker in $$workers
do
    do_ssh \
        "Executing $${command}" \
        ${admin}@$${worker} \
        "~/scripts/worker.sh" &

    # do_ssh \
    #     "Execute worker.sh" \
    #     ${admin}@$${worker} \
    #     "~/scripts/worker.sh"

    # do_ssh \
    #     "Execute kubeadm_join_cmd.sh" \
    #     ${admin}@$${worker} \
    #     "sudo ~/scripts/kubeadm_join_cmd.sh"
done

IFS=$" "
while true
do
    current_jobs=$(jobs)
    if [ "$${current_jobs}X" == "X" ]
    then
        break;
    else
        echo "Background jobs still running: Sleeping for 30s"
        sleep 30
    fi
done

banner "ssh-commands.sh" "Execute load-traefik.sh on first master"
master=(${masters})
do_ssh \
    "Execute load-traefik.sh" \
    ${admin}@$${master[0]} \
    "~/scripts/traefik/load-traefik.sh"

banner "ssh-commands.sh" "Instruct all nodes to reboot"
IFS=$" "
for target in $$masters $$workers
do
    do_ssh \
        "Set scripts to be executable on $${target}" \
        ${admin}@$${target} \
        "sudo reboot now"
done

banner "DONE ssh-commands.sh" "Completed all commands on all machines"
IFS=$" "
