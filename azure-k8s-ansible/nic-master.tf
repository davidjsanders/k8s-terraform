# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nic-jumpox.tf
# Environments:   all
# Purpose:        Module to define the Azure network interface card
#                 (nic) for the VM Jumpbox.
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

resource "azurerm_network_interface" "k8s-nic-master" {
  location = var.location
  name = format(
    "NIC-MASTER-%s-%s%s",
    var.target,
    var.environ,
    local.l-random,
  )
  resource_group_name = azurerm_resource_group.k8s-rg.name

  ip_configuration {
    name = format(
      "NIC-MASTER-IPCONFIG-%s-%s%s",
      var.target,
      var.environ,
      local.l-random,
    )
    private_ip_address_allocation = "Static"
    private_ip_address = cidrhost(
      azurerm_subnet.k8s-subnet-master.address_prefix,
      5)
    subnet_id                     = azurerm_subnet.k8s-subnet-master.id
  }

  tags       = var.tags
  depends_on = [azurerm_subnet.k8s-subnet-master]
}

