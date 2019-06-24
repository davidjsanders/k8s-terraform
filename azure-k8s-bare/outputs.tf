# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      outputs.tf
# Environments:   all
# Purpose:        Module to display key outputs for the current tf
#                 run.
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

output "LoadBalancer-fqdn" {
    value = "${module.pip-elb.fqdn}"
}

output "Jumpbox-fqdn" {
    value = "${module.pip-jumpbox.fqdn}"
}

output "LoadBalancer-IP-Address" {
    value = "${module.pip-elb.ip_address}"
}

output "Jumpbox-IP-Address" {
    value = "${module.pip-jumpbox.ip_address}"
}

output "nginx-hosts-line" {
    value = "${module.pip-elb.ip_address}    nginx-frontend"
}

output "traefik-hosts-line" {
    value = "${module.pip-elb.ip_address}    traefik-ui"
}