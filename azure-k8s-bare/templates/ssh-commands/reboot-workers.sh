# Reboot all of the workers
banner "ssh-commands.sh" "Reboot all workers"
IFS=$" "
for worker in $$workers
do
    do_ssh \
        "Executing $${command}" \
        ${admin}@$${worker} \
        "sudo reboot now"
done
