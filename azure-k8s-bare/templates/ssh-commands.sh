#!/bin/bash
source /home/${admin}/scripts/banner.sh
source /home/${admin}/scripts/do-ssh.sh
source /home/${admin}/scripts/do-ssh-nohup.sh
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
master_commands="$${master_commands};cat /home/${admin}/hosts | sudo tee -a /etc/hosts"
master_commands="$${master_commands};~/scripts/master.sh"
IFS=$" "
for master in $$masters
do
    IFS=$';'
    for command in $$master_commands
    do
        do_ssh \
            "Executing $${command}" \
            ${admin}@$${master} \
            $${command}
    done
done

banner "ssh-commands.sh" "Copy kubeadm_join_cmd.sh to all workers"
IFS=$" "
for worker in $$workers
do
    do_scp \
        "Copy kubeadm_join_cmd.sh to $$worker" \
        k8s-master:/home/${admin}/kubeadm_join_cmd.sh \
        $$worker:/home/${admin}/kubeadm_join_cmd.sh
done

banner "ssh-commands.sh" "Instruct masters to reboot"
IFS=$" "
for target in $$masters
do
    do_ssh \
        "Reboot node $${target}" \
        ${admin}@$${target} \
        "sudo reboot now"
done

banner "ssh-commands.sh" "Execute ssh commands on all workers"
worker_commands="~/scripts/worker.sh"
IFS=$" "
for worker in $$workers
do
    do_ssh \
        "Setup hosts file" \
        ${admin}@$${worker} \
        "cat /home/${admin}/hosts | sudo tee -a /etc/hosts"

    do_ssh_nohup \
        "Executing $${command}" \
        ${admin}@$${worker} \
        "~/scripts/worker.sh"
done

banner "ssh-commands.sh" "Wait for workers to complete"
worker_array=(${workers})
sleep_time=30
IFS=$" "
while true
do
    files=$(ls -m *.done)
    done_files=(`echo $files`)

    echo "Done notices : $${#done_files[@]}"
    echo "Workers      : $${#worker_array[@]}"

    if [ "$${#done_files[@]}" == "$${#worker_array[@]}" ]
    then
        echo "Staus        : All workers report done."
        break;
    else
        echo "Status       : Jobs still running; sleeping for $${sleep_time}s"
        sleep $${sleep_time}
    fi
done

banner "ssh-commands.sh" "Reboot all workers"
IFS=$" "
for worker in $$workers
do
    do_ssh \
        "Executing $${command}" \
        ${admin}@$${worker} \
        "sudo reboot now"
done

banner "ssh-commands.sh" "Execute load-traefik.sh on first master"
master=(${masters})
do_ssh \
    "Execute load-traefik.sh" \
    ${admin}@$${master[0]} \
    "~/scripts/traefik/load-traefik.sh"

banner "DONE ssh-commands.sh" "Completed all commands on all machines"
IFS=$" "
