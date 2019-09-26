# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-ssh-config.tf
# Environments:   all
# Purpose:        Module to get the persistent Azure managed disks.
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

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-ssh-config" {
  template = file("template-data/config")

  vars = {
    hosts = join(
      " ",
      concat(
        ["k8s-master"],
        ["jumpbox"],
        [
          for i in range(0, var.workers.vm-count) : 
            format(
              "%s-%01d",
              var.workers.prefix,
              i+1
            )
        ]
      )
    )

    # hosts = "k8s-master %{ for i in range(1, var.workers.vm-count+1) ~}${var.workers.prefix}-${i} %{ endfor ~} jumpbox"
  }
}

