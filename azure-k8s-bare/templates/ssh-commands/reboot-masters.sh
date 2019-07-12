# After copying the script, the master is rebooted.
banner "ssh-commands.sh" "Instruct masters to reboot"
IFS=$" "
for target in $$masters
do
    do_ssh \
        "Reboot node $${target}" \
        ${admin}@$${target} \
        "sudo reboot now"
done
