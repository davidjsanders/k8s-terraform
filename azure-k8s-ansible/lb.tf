# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      lb.tf
# Environments:   all
# Purpose:        Module to define the Azure load balancer to load
#                 balance ingress into the cluster.
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

resource "azurerm_lb" "k8s-lb" {
  location = var.location
  name = upper(
    format(
      "%s-LB-%s-%s%s",
      var.lb-name,
      var.target,
      var.environ,
      local.l-random,
    ),
  )
  resource_group_name = azurerm_resource_group.k8s-rg.name
  sku                 = "Basic"

  tags = var.tags

  frontend_ip_configuration {
    name = upper(
      format(
        "%s-FE-PIP-%s-%s%s",
        var.lb-name,
        var.target,
        var.environ,
        local.l-random,
      ),
    )
    public_ip_address_id = azurerm_public_ip.k8s-pip-lb.id
  }
}

