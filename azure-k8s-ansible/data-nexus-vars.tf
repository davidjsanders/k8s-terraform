# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-ansible-inventory.tf
# Environments:   all
# Purpose:        Module to set the data in the Ansible playbook
#                 for all variables.
#
# Created on:     15 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 15 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-nexus-vars" {
  template = file("template-data/k8s-nexus-vars.yml")

  vars = {
    domain_name = var.ddns_domain_name
  }
}

