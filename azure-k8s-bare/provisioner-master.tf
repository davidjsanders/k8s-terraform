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
        content = "${data.template_file.ssh-config.rendered}"
        destination = "~/.ssh/config"
    }

    provisioner "file" {
        source = "${local.l_pk_file}"
        destination = "~/.ssh/azure_pk"
    }

    provisioner "file" {
        source = "${local.l_pk_file}.pub"
        destination = "~/.ssh/azure_pk.pub"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 0600 ~/.ssh/azure_pk",
            "chmod +x ~/master.sh",
            "~/master.sh",
            "echo ''"
        ]
    }
}