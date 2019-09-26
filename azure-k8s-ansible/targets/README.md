# About the **targets** directory
To run this Terraform/Ansible play, this repo expects a number of files to be created in the targets directory

* beconf.tfvars - The backend configuration variables
* credentials.secret - The secrets used to interact with Azure
* dev.tfvars - The variables used for the Terraform script

The beconf.tfvars and credentials.secret are included in .gitignore so that they are not tracked by Git. The def.tfvars should contain *NO* secrets and should be Git-safe.

## beconf.tfvars
The beconf.tfvars in the targets directory provides the settings for how the Terraform state will be stored in Azure and should contain:

* resource_group_name: The Azure resource group name where Terraform state will be held, e.g. `resource_group_name="RG-TFSTATE`
* storage_account_name: The Storage Account that will be used 
* container_name
* key
* access_key 