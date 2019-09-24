# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      nic-jumpox.tf
# Environments:   all
# Purpose:        Module to define the Azure network interface card
#                 (nic) for the VM workers.
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
# 23 Sep 2019  | David Sanders               | Add support for
#              |                             | variable number
#              |                             | of workers.
# -------------------------------------------------------------------

resource "azurerm_network_interface" "k8s-nic-workers" {
  count = var.workers.vm-count

  location = var.location
  name = format(
    "NIC-WORKER-%02d-%s-%s%s",
    count.index + 1,
    var.target,
    var.environ,
    local.l-random,
  )
  resource_group_name = azurerm_resource_group.k8s-rg.name

  ip_configuration {
    name = format(
      "NIC-WORKER-%02d-IPCONFIG-%s-%s%s",
      count.index + 1,
      var.target,
      var.environ,
      local.l-random,
    )
    private_ip_address_allocation = "Static"
    # Offset by 5 for Azure reserved devices
    private_ip_address = cidrhost(
      azurerm_subnet.k8s-subnet-worker.address_prefix,
      5 + count.index)
    subnet_id = azurerm_subnet.k8s-subnet-worker.id
  }

  tags       = var.tags
  depends_on = [
    azurerm_subnet.k8s-subnet-worker
  ]
}
