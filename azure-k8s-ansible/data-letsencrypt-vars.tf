# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-letsencypt-vars.tf
# Environments:   all
# Purpose:        Module to get the variables for Letsencrypt
#
# Created on:     19 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 19 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-letsencrypt" {
  template = file("template-data/k8s-letsencrypt-vars.yml")

  vars = {
    email = var.email
    domain = var.ddns_domain_name
  }
}

