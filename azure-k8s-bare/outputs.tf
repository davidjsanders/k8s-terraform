output "fqdn" {
    value = "${module.pip-master-1.fqdn}"
}

output "IP-Address" {
    value = "${module.pip-master-1.ip_address}"
}

output "Jumpbox-IP-Address" {
    value = "${module.pip-jumpbox.ip_address}"
}

output "nginx-hosts-line" {
    value = "${module.pip-master-1.ip_address}    nginx-frontend"
}

output "traefik-hosts-line" {
    value = "${module.pip-master-1.ip_address}    traefik-ui"
}