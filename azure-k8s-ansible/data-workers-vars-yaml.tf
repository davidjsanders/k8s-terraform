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
data "template_file" "template-workers-vars-yml" {
  template = file("template-data/k8s-workers-vars.yml")

  vars = {
    worker_1 = lower(format(
        "%s-WORKER-%01d-%s-%s%s",
        var.vm-name,
        1,
        var.target,
        var.environ,
        local.l-random,
      ))
    worker_2 = lower(format(
        "%s-WORKER-%01d-%s-%s%s",
        var.vm-name,
        2,
        var.target,
        var.environ,
        local.l-random,
      ))
    master = lower(format(
        "%s-MASTER-%01d-%s-%s%s",
        var.vm-name,
        1,
        var.target,
        var.environ,
        local.l-random,
      ))
    admin    = var.vm-adminuser
  }
}

# TODO: Use vars from tf.vars, e.g. api advertise ip
