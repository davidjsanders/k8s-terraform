# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-hosts-file.tf
# Environments:   all
# Purpose:        Module to get the persistent Azure managed disks.
#
# Created on:     10 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-hosts-file" {
  template = file("template-data/hosts")

  vars = {
    master  = azurerm_network_interface.k8s-nic-master.private_ip_address
    worker1 = azurerm_network_interface.k8s-nic-workers[0].private_ip_address
    worker2 = azurerm_network_interface.k8s-nic-workers[1].private_ip_address
    jumpbox = azurerm_network_interface.k8s-nic-jumpbox.private_ip_address
  }
}

