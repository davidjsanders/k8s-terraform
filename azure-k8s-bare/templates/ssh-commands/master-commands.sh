# Define the commands that should be executed on the master. TODO: 
# These should probably ALL be in master.sh rather than split here
# and most in the other shell script.
banner "ssh-commands.sh" "Execute ssh commands on master"

# Make the mountpoint for the NFS drive
master_commands="sudo mkdir /datadrive"

# Mount the NFS drive
master_commands="$${master_commands};sudo mount /dev/sdc1 /datadrive"

# Change the ownership of *EVERYTHING* in the drive to the admin user
master_commands="$${master_commands};sudo chown -R ${admin} /datadrive/azadmin"

# Setup the hosts file
master_commands="$${master_commands};cat /home/${admin}/hosts | sudo tee -a /etc/hosts"

# Move the registry files from the scripts dir to the home dir
master_commands="$${master_commands};mv /home/${admin}/scripts/registry /home/${admin}/registry"

# Execute the steps required to setup a k8s master
master_commands="$${master_commands};~/scripts/master.sh"

# Execute the commands on every master
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
