# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-ansible-inventory.tf
# Environments:   all
# Purpose:        Module to set the Ansible inventory (hosts) file
#                 to contain the actual private IP addresses of all
#                 hosts.
#
# Created on:     11 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 11 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-ansible-inventory" {
  template = "${file("ansible/inventory")}"

  vars {
    master   = "${azurerm_network_interface.k8s-nic-master.private_ip_address}"
    worker-1 = "${azurerm_network_interface.k8s-nic-workers.*.private_ip_address[0]}"
    worker-2 = "${azurerm_network_interface.k8s-nic-workers.*.private_ip_address[1]}"
    jumpbox  = "${azurerm_network_interface.k8s-nic-jumpbox.private_ip_address}"
    admin    = "${var.vm-adminuser}"
  }
}

