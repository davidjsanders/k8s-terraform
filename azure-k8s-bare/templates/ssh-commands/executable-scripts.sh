# Define the scripts that should be set to executable.
banner "ssh-commands.sh" "Set all scripts on all machines to be executable"
executable_scripts="/home/$admin/scripts/traefik/load-traefik.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/registry/load-registry.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/master.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/worker.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/scp-commands.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/ssh-commands.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/local-storage/load.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/local-storage/delete.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/registry/load-registry.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/registry/delete-registry.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/nexus-oss/load-nexus-oss.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/nexus-oss/delete-nexus-oss.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/helm/load-helm.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/helm/delete-helm.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/nfs-provisioner/load-nfs-provisioner.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/nfs-provisioner/delete-nfs-provisioner.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/k8s-jenkins/load-jenkins.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/k8s-jenkins/delete-jenkins.sh"
executable_scripts="$executable_scripts /home/$admin/scripts/k8s-jenkins/get-jenkins-cloud-setup.sh"

# Execute an ssh command on every node and set the executable
# flag on the scripts and setup the hosts file
IFS=$" "
for target in $masters $workers
do
    do_ssh \
        "Set scripts to be executable on ${target}" \
        $admin@${target} \
        "chmod +x ${executable_scripts}"

    do_ssh \
        "Setup hosts file on ${target}" \
        $admin@${target} \
        "cat /home/$admin/hosts | sudo tee -a /etc/hosts"
done

