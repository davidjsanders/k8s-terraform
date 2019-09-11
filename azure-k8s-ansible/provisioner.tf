# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      main.tf
# Environments:   all
# Purpose:        Terraform main.tf module.
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

resource "null_resource" "provisioner" {
    triggers {
        vm_jumpbox_id      = "${azurerm_virtual_machine.vm-jumpbox.id}"
        vm_k8s_master_1_id = "${azurerm_virtual_machine.vm-master.id}"
        vm_k8s_worker_1_id = "${azurerm_virtual_machine.vm-workers.*.id[0]}"
        vm_k8s_worker_2_id = "${azurerm_virtual_machine.vm-workers.*.id[1]}"
    }

    connection {
        host        = "${azurerm_public_ip.k8s-pip-jump.ip_address}"
        type        = "ssh"
        user        = "${var.vm-adminuser}"
        private_key = "${file(local.l_pk_file)}"
    }

    provisioner "file" {
        source = "${local.l_pk_file}"
        destination = "/home/${var.vm-adminuser}/.ssh/azure_pk"
    }

    provisioner "file" {
        source = "setup-scripts/setup-jumpbox.sh"
        destination = "/home/${var.vm-adminuser}/setup-jumpbox.sh"
    }

    provisioner "file" {
        content = "${data.template_file.template-hosts-file.rendered}"
        destination = "/home/${var.vm-adminuser}/hosts"
    }

    provisioner "file" {
        content = "${data.template_file.template-ssh-config.rendered}"
        destination = "/home/${var.vm-adminuser}/.ssh/config"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x ~/setup-jumpbox.sh",
            "~/setup-jumpbox.sh",
            "echo 'Done.'"
        ]
    }

}
