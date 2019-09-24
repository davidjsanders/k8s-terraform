# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      worker-nsg-association.tf
# Environments:   all
# Purpose:        Module to associate the worker subnet to the
#                 Network Security Group.
#
# Created on:     16 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 16 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 23 Sep 2019  | David Sanders               | Add support for
#              |                             | variable number
#              |                             | of workers.
# -------------------------------------------------------------------

resource "azurerm_network_interface_backend_address_pool_association" "lb-assoc-worker-1" {
  count = var.workers.vm-count

  network_interface_id    = azurerm_network_interface.k8s-nic-workers[count.index].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.k8s-lb-bepool.id
  ip_configuration_name = format(
    "NIC-WORKER-%02d-IPCONFIG-%s-%s%s",
    count.index + 1,
    var.target,
    var.environ,
    local.l-random,
  )

}
