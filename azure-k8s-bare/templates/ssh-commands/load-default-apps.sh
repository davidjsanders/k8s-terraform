# Load the collection of apps we want to apply to our new k8s
# cluster in advance of starting. There should really be a check
# here to make sure all the nodes are ready, although k8s should
# proceed okay.
scripts="/home/$admin/scripts/traefik/load-traefik.sh"
scripts="$scripts;/home/$admin/registry/load-registry.sh"
#scripts="$scripts;/home/$admin/scripts/nexus-oss/load-nexus-oss.sh"
scripts="$scripts;/home/$admin/scripts/helm/load-helm.sh"
scripts="$scripts;/home/$admin/scripts/nfs-provisioner/load-nfs-provisioner.sh"

# Loop through the list of scripts and source each one in 
# order. Note the IFS is ;
banner "ssh-commands.sh" "Loading kubernetes apps"
master=(${masters})
IFS=$";"
for script in $scripts
do
    banner "ssh-commands.sh" "Loading $script"
    do_ssh \
        "Execute $script" \
        $admin@${master[0]} \
        "${script}"
done
IFS=$" "
