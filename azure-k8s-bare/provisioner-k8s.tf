# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      provisioner-k8s.tf
# Environments:   all
# Purpose:        Module to define provisioners to configure the nodes
#                 after provisioning.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "null_resource" "k8s" {
    triggers {
        vm_master_1_id = "${module.vm-jumpbox.id}"
        vm_k8s_master_1_id = "${module.vm-manager-1.id}"
        vm_k8s_worker_1_id = "${module.vm-worker-1.id}"
        vm_k8s_worker_2_id = "${module.vm-worker-2.id}"
    }

    connection {
        host        = "${module.pip-jumpbox.ip_address}"
        type        = "ssh"
        user        = "${var.vm-adminuser}"
        private_key = "${file(local.l_pk_file)}"
    }

    provisioner "local-exec" {
        command = "echo; echo '*** Sleeping for 20s to allow host to wake'; echo; sleep 20"
    }

    provisioner "remote-exec" {
        inline = ["mkdir -p ~/scripts"]
    }

    provisioner "file" {
        source = "templates/"
        destination = "/home/${var.vm-adminuser}/scripts"
    }

    provisioner "file" {
        content = "${data.template_file.master-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/master.sh"
    }

    provisioner "file" {
        content = "${data.template_file.worker-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/worker.sh"
    }

    provisioner "file" {
        content = "${data.template_file.setup-nfs-server-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/k8s-scripts/setup-nfs-server.sh"
    }

    provisioner "file" {
        content = "${data.template_file.scp-commands-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/scp-commands.sh"
    }

    provisioner "file" {
        content = "${data.template_file.ssh-commands-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/ssh-commands.sh"
    }
    provisioner "file" {
        content = "${data.template_file.ssh-config.rendered}"
        destination = "/home/${var.vm-adminuser}/.ssh/config"
    }

    provisioner "file" {
        content = "${data.template_file.hosts.rendered}"
        destination = "/home/${var.vm-adminuser}/hosts"
    }

    provisioner "file" {
        source = "${local.l_pk_file}"
        destination = "/home/${var.vm-adminuser}/.ssh/azure_pk"
    }

    provisioner "file" {
        source = "templates/traefik"
        destination = "/home/${var.vm-adminuser}/scripts"
    }

    provisioner "file" {
        source = "${local.l_pk_file}.pub"
        destination = "/home/${var.vm-adminuser}/.ssh/azure_pk.pub"
    }

    provisioner "file" {
        content = "${data.template_file.ingress-yaml.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/traefik/5-ingress.yaml"
    }

    provisioner "file" {
        content = "${data.template_file.lbip-txt.rendered}"
        destination = "/home/${var.vm-adminuser}/lbip.txt"
    }

    provisioner "file" {
        content = "${data.template_file.helm-rbac-role-yaml.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/helm/helm-rbac-role.yaml"
    }

    provisioner "file" {
        content = "${data.template_file.load-helm-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/helm/load-helm.sh"
    }

    provisioner "file" {
        content = "${data.template_file.delete-helm-sh.rendered}"
        destination = "/home/${var.vm-adminuser}/scripts/helm/delete-helm.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "cat /home/${var.vm-adminuser}/hosts | sudo tee -a /etc/hosts",
            "chmod 0600 /home/${var.vm-adminuser}/.ssh/azure_pk",
            "chmod +x /home/${var.vm-adminuser}/scripts/traefik/load-traefik.sh /home/${var.vm-adminuser}/scripts/master.sh /home/${var.vm-adminuser}/scripts/worker.sh /home/${var.vm-adminuser}/scripts/scp-commands.sh /home/${var.vm-adminuser}/scripts/ssh-commands.sh",
            "mkdir /home/${var.vm-adminuser}/logs",
            "/home/${var.vm-adminuser}/scripts/scp-commands.sh | tee /home/${var.vm-adminuser}/logs/scp-commands.log",
            "/home/${var.vm-adminuser}/scripts/ssh-commands.sh | tee /home/${var.vm-adminuser}/logs/ssh-commands.log",
            "echo 'Done.'"
        ]
    }
}