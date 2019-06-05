output "fqdn" {
    value = "${module.pip-docker-master-1.fqdn}"
}

output "IP-Address" {
    value = "${module.pip-docker-master-1.ip_address}"
}

output "Connect-to-Docker" {
    value = "export DOCKER_HOST=${module.pip-docker-master-1.ip_address}:2376; export DOCKER_TLS_VERIFY=1; export DOCKER_CERT_PATH=~/.docker/azure-${module.pip-docker-master-1.ip_address}"
}

output "Connect-to-cowbull" {
    value = "curl -H \"Host:cowbull\" ${module.pip-docker-master-1.ip_address}"
}

output "etc-hosts-line" {
    value = "${module.pip-docker-master-1.ip_address}    cowbull"
}