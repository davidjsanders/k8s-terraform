# About the **targets** directory
To run the Terraform, this repo expects a number of files to be created in the targets directory

* beconf.tfvars - The backend configuration variables
* credentials.secret - The secrets used to interact with Azure
* dev.tfvars - The variables used for the Terraform script

Examples are provided in the samples directory and these can be edited and copied to the targets directory (which the .gitignore to ignore *.secret, *-run and *.tfvars)
