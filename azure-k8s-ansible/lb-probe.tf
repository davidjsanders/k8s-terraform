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

resource "azurerm_lb_probe" "k8s-lb-probe" {
  resource_group_name = "${azurerm_resource_group.k8s-rg.name}"
  loadbalancer_id     = "${azurerm_lb.k8s-lb.id}"
  name                = "http-probe"
  port                = 80
}