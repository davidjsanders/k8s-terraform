# Samples
## beconf.tfvars
The beconf.tfvars holds the backend configuration variables for the scripts. There are five key variables that must be populated:

* `resource_group_name` - this is the Azure Resource Group name for the RG that contains the `terraformstate` Storage Account. In the main README, this is the RG called `RG-TFSTATE`.
* `storage_account_name` - this is the name of the Storage Account used to hold terraform state. In the main README, this is the SA called `terraformstate`.
* `container_name` - this is the name of the container in the SA `terraformstate` and can be called anything; a good example is `infrastructure-state`.
* `key` - this is the key for the file in the container and can be called anything. This key *is* important; if the Terraform scipt fails for some reason, you may need to break the lease on this key to re-run.
* `access_key` - this is key1 or key2 from the container.

## credentials.secret
> This file should be set to 0600 **AND** added to the .gitignore (e.g. `**/targets/*.secret`) to prevent any secret information from being leaked into GitHub.

The credentials.secret file contains the secrets required to access your Azure subscription; in a production environment, it is recommended to contain this information in HashiCorp Vault (or another secrets engine).

The file should contain four keys:

* `client_id` - A client ID for an app created in the Azure portal.
* `client_secret` - A client secret for an app created in the Azure portal.
* `tenant_id` - The tenant ID for your Azure subscription.
* `subscription_id` - The subscription ID for your Azure subscription.

> If you need guidance finding and creating this information, refer to the Azure documentation.

## dev.tfvars
The dev.tfvars file contains the variables used to set the names of Azure resources and their configuration.

This file is self-documenting, so please refer to it directly.