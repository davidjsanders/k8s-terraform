# About the **targets** directory
To run this Terraform/Ansible play, this repo expects a number of files to be created in the targets directory

* beconf.tfvars - The backend configuration variables
* credentials.secret - The secrets used to interact with Azure
* dev.tfvars - The variables used for the Terraform script

The beconf.tfvars and credentials.secret are included in .gitignore so that they are not tracked by Git. The def.tfvars should contain *NO* secrets and should be Git-safe.

## beconf.tfvars
The beconf.tfvars in the targets directory provides the settings for how the Terraform state will be stored in Azure and should contain:

* resource_group_name: The resource group name where Terraform state will be held, e.g. `resource_group_name="RG-TFSTATE`
* storage_account_name: The Storage Account that will be used, e.g. `storage_account_name = "mystorageaccount"`
* container_name: The SA container name that will be used, e.g. `container_name="infrastructure-state"`
* key: The SA key used to identify the state file, e.g. `key = "k8s-ansible"`
* access_key: The storage account key to access the SA, e.g. `1a2b3c4d...==`

## credentials.secret
The credential.secret file should be an owner, read-only file (`0600`) which contains sensitive variables that are provided from a non-Git source (e.g. Vault, etc.). This file must contain:

* client_id = "..."
> The Azure service principal (SPN) Terraform uses to interact with Azure.
* client_secret = "..."
> The secret for the SPN
* tenant_id = "..."
> The tenant ID
* subscription_id = "..."
> The Subscription to be used
* ddns_domain_name=".my.domain.com"
> A Google Domains domain name that will be suffixed to all ingresses
* wild_username="..."
> The username for the Google DDNS service
* wild_password="..."
> The password for the Google DDNS service
* jumpbox_domain_name="jumpbox.my.domain.com"
> A Google Domains domain name that will be used for the jumpbox
* jumpbox_username="..."
> The Google Domains username **NOT** the Jumpbox username
* jumpbox_password="..."
> The Google Domains password **NOT** the Jumpbox password
* auth_file="..."
> An http auth file for basic auth
* vm-adminuser = "..."
> The username of the Azure VMs (the admin)
* vm-adminpass = "..."
> A simple password which is disabled although settings prevent password based logon.
* disk-master-name = "managed-disk-name"
> An existing persistant Azure managed disk name
* disk-rg-name = "managed-disk-rg"
> An existing persistant Azure managed disk resource group name
* email="someone@gmail.com"
> Email ID to use with the Let's Encrypt service
* nexus_dns_name="nexus.my.domain.com"
> An fqdn for the TLS prod Nexus OSS service.
