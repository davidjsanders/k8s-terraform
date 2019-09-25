# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      data.tf
# Environments:   all
# Purpose:        Module to populate data items with content from Azure
#                 and to interpolate variables.
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 26 Aug 2019  | David Sanders               | Process load-traefik.sh
#              |                             | and load-nexus.sh
#              |                             | Remove deprecated code.
#              |                             | Add processing to a text
#              |                             | file called domain_name
# -------------------------------------------------------------------

# Get the managed disk being used to provide persistent storage
# for the k8s cluster.
data "azurerm_managed_disk" "datasourcemd" {
  name                = "${var.disk-master-name}"
  resource_group_name = "${var.disk-rg-name}"
}

# Compute and interpolate the variables required for master.sh
data "template_file" "master-sh" {
  template = "${file("templates/master.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for worker.sh
data "template_file" "worker-sh" {
  template = "${file("templates/worker.sh")}"

  vars {
    admin="${var.vm-adminuser}"
  }
}

# Compute and interpolate the variables required for the hosts file
data "template_file" "hosts" {
  template = "${file("templates/hosts")}"

  vars {
    master="${local.l-pnic-master-1-ip}"
    worker1="${local.l-nic-worker-1-ip}"
    worker2="${local.l-nic-worker-2-ip}"
    jumpbox="${local.l-pnic-jumpbox-1-ip}"
  }
}

# Compute and interpolate the variables required for scp-commands.sh
data "template_file" "scp-commands-sh" {
  template = "${file("templates/scp-commands.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    copy_targets="${local.l-pnic-master-1-ip} ${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for ssh-commands.sh
data "template_file" "ssh-commands-sh" {
  template = "${file("templates/ssh-commands.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    masters="${local.l-pnic-master-1-ip}"
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
  }
}

# Compute and interpolate the variables required for the ssh config
# file
data "template_file" "ssh-config" {
  template = "${file("templates/config")}"

  vars {
  }
}

# Compute and interpolate the variables required for setup-nfs-server.sh
data "template_file" "setup-nfs-server-sh" {
  template = "${file("templates/k8s-scripts/setup-nfs-server.sh")}"

  vars {
    workers="${local.l-nic-worker-1-ip} ${local.l-nic-worker-2-ip}"
    masters="${local.l-pnic-master-1-ip}"
  }
}

# Compute and interpolate the variables required for load-traefik.sh
# in the Traefik app
data "template_file" "load-traefik-sh" {
  template = "${file("templates/traefik/load-traefik.sh")}"

  vars {
    domain_name="${var.ddns_domain_name}"
    auth_file="${var.auth_file}"
  }
}

# Compute and interpolate the variables required for load-nexus.sh
# in the Nexus app
data "template_file" "load-nexus-oss-sh" {
  template = "${file("templates/nexus-oss/load-nexus-oss.sh")}"

  vars {
    domain_name="${var.ddns_domain_name}"
  }
}

# Compute and interpolate the variables required for lbip.txt
# for the Traefik Ingress Controller
data "template_file" "lbip-txt" {
  template = "${file("templates/lbip.txt")}"

  vars {
    lbip="${module.pip-elb.ip_address}"
  }
}

# Compute and interpolate the variables required for domain_name.txt
# for the Traefik Ingress Controller
data "template_file" "domain_name-txt" {
  template = "${file("templates/domain_name.txt")}"

  vars {
    domain_name="${var.ddns_domain_name}"
  }
}

# Compute and interpolate the variables required for Helm setup
data "template_file" "helm-rbac-role-yaml" {
  template = "${file("templates/helm/helm-rbac-role.yaml")}"

  vars {
    tiller_user="${var.helm_service_account_name}"
  }
}

data "template_file" "load-helm-sh" {
  template = "${file("templates/helm/load-helm.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    tiller_user="${var.helm_service_account_name}"
  }
}

data "template_file" "delete-helm-sh" {
  template = "${file("templates/helm/load-helm.sh")}"

  vars {
    admin="${var.vm-adminuser}"
    tiller_user="${var.helm_service_account_name}"
  }
}
