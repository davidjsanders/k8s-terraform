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
data "template_file" "template-play-vars-yml" {
  template = file("template-data/k8s-master-vars.yml")

  vars = {
    kubeadm_api              = "kubeadm.k8s.io"
    kubeadm_api_version      = "v1beta1"
    kubeadm_api_advertise_ip = "10.70.1.6"
    kubeadm_cert_dir         = "/etc/kubernetes/pki"
    kubeadm_cluster_name     = "kubernetes"
    kubeadm_pod_subnet       = "192.168.0.0/16"
    kubeadm_service_subnet   = "10.96.0.0/12"
    kubeadm_k8s_version      = "v1.14.3"
    admin                    = var.vm-adminuser
  }
}

# TODO: Use vars from tf.vars, e.g. api advertise ip
