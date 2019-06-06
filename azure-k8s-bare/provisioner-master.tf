resource "null_resource" "k8s_master" {
    triggers {
        vm_master_1_id = "${module.vm-manager-1.id}"
    }

    connection {
        host        = "${module.pip-master-1.ip_address}"
        type        = "ssh"
        user        = "azadmin"
        private_key = "${file(local.l_pk_file)}"
    }

    provisioner "local-exec" {
        command = "echo; echo '*** Sleeping for 20s to allow host to wake'; echo; sleep 20"
    }

    provisioner "file" {
        content = "${data.template_file.master-sh.rendered}"
        destination = "~/master.sh"
    }

    provisioner "file" {
        content = "${data.template_file.worker-sh.rendered}"
        destination = "~/worker.sh"
    }

    provisioner "file" {
        content = "${data.template_file.ssh-config.rendered}"
        destination = "~/.ssh/config"
    }

    provisioner "file" {
        source = "${local.l_pk_file}"
        destination = "~/.ssh/azure_pk"
    }

    provisioner "file" {
        source = "templates/traefik"
        destination = "~/"
    }

    # provisioner "file" {
    #     source = "templates/traefik/3-daemonset.yaml"
    #     destination = "~/traefik/3-daemonset.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/4-service.yaml"
    #     destination = "~/traefik/4-service.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/5-ingress.yaml"
    #     destination = "~/traefik/5-ingress.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/6-nginx.yaml"
    #     destination = "~/traefik/6-nginx.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/7-nginx-service.yaml"
    #     destination = "~/traefik/7-nginx-service.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/8-nginx-ingress.yaml"
    #     destination = "~/traefik/8-nginx-ingress.yaml"
    # }

    # provisioner "file" {
    #     source = "templates/traefik/load-traefik.sh"
    #     destination = "~/traefik/load-traefik.sh"
    # }

    provisioner "file" {
        source = "${local.l_pk_file}.pub"
        destination = "~/.ssh/azure_pk.pub"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 0600 ~/.ssh/azure_pk",
            "chmod +x ~/master.sh",
            "chmod +x ~/worker.sh",
            "chmod +x ~/traefik/load-traefik.sh",
            "mkdir ~/logs",
            "~/master.sh | tee ~/master.log",
            "scp -i ~/.ssh/azure_pk ~/worker.sh ${local.l-nic-worker-1-ip}:~/worker.sh",
            "scp -i ~/.ssh/azure_pk ~/worker.sh ${local.l-nic-worker-2-ip}:~/worker.sh",
            "scp -i ~/.ssh/azure_pk ~/kubeadm_join_cmd.sh ${local.l-nic-worker-1-ip}:~/kubeadm_join_cmd.sh",
            "scp -i ~/.ssh/azure_pk ~/kubeadm_join_cmd.sh ${local.l-nic-worker-2-ip}:~/kubeadm_join_cmd.sh",
            "ssh -i ~/.ssh/azure_pk ${local.l-nic-worker-1-ip} ~/worker.sh | tee logs/worker-1.log",
            "ssh -i ~/.ssh/azure_pk ${local.l-nic-worker-2-ip} ~/worker.sh | tee logs/worker-2.log",
            "ssh -i ~/.ssh/azure_pk ${local.l-nic-worker-1-ip} sudo ~/kubeadm_join_cmd.sh | tee logs/kubeadm_join_cmd-1.log",
            "ssh -i ~/.ssh/azure_pk ${local.l-nic-worker-2-ip} sudo ~/kubeadm_join_cmd.sh | tee logs/kubeadm_join_cmd-2.log",
            "~/traefik/load-traefik.sh | tee load-traefik.log",
            "echo ''",
            "kubectl get nodes -o wide",
            "echo ''",
            "echo 'Done.'"
        ]
    }
}