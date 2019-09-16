# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      lb-rule.tf
# Environments:   all
# Purpose:        Module to define the Azure load balancer rules
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

resource "azurerm_lb_rule" "k8s-lb-rule-80" {
  resource_group_name            = "${azurerm_resource_group.k8s-rg.name}"
  loadbalancer_id                = "${azurerm_lb.k8s-lb.id}"
  name                           = "port80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${upper(format("%s-FE-PIP-%s-%s%s", var.lb-name, var.target, var.environ, local.l-random))}"
}