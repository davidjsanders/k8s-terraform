# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      lb-probe.tf
# Environments:   all
# Purpose:        Module to define the Azure load balancer probe
#                 for the cluster load balancer.
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
# 18 Sep 2019  | David Sanders               | Add 443 probe.
# -------------------------------------------------------------------
# 01 Oct 2019  | David Sanders               | Fix probes to 
#              |                             | assign to correct probe
#              |                             | to rule and base on
#              |                             | variables.
# -------------------------------------------------------------------

resource "azurerm_lb_probe" "k8s-lb-probes" {
  count = length(var.lb-ports)

  resource_group_name = azurerm_resource_group.k8s-rg.name
  loadbalancer_id     = azurerm_lb.k8s-lb.id
  name                = format(
                          "%s-probe", 
                          var.lb-ports.*.name[count.index]
                        )
  port                = var.lb-ports.*.backend-port[count.index]
}
