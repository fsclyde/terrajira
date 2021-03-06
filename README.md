# terrajira


Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

For more information about terraform: [here](https://www.terraform.io/intro/index.html)

This module allows you to set up the following components by using terraform:

* Jira Software: Hosted on Google Cloud 
* Database Jira: Hosted on AWS RDS 
* jenkins Server: Hosted on AWS ec2 micro

![ TerraJiraImage ](https://github.com/fsclyde/terrajira/blob/master/images/TerraProject.jpg)


### installation and configuration

### On your filesystem

// Generate private / public key to connect to your AWS instance

    ssh-keygen -b 4096 -f ~/.ssh/id_rsa.pub

// SSH connection

    ssh -i ~/.ssh/id_rsa ec2_user@ec2-[DNS].compute.amazonaws.com

#### AWS prerequisites 

1) Roles and Access keys configuration
2) Give the proper permission to the roles 
3) Configure the userscript and rds password textfile

Add the following lines to the script *creds/secret.tfvars*

    rds_username=[username]
    rds_password=[password]
    
Add the following lines to the script *creds/secret.sh*

    export ACCESS_KEY="[AWS Access key]"
    export SECRET_KEY="[AWS Secret key]"
    
Add the following lines to the script *creds/google_secret.json*

    Add the Google JSON credentials downloaded from Google Cloud Platform

   
#### Google Cloud Platform prerequisites 

1) Create google cloud credentials JSON make sure the project ID match
2) Enable "Cloud Resource Manager API"

### terraform

##### Execute the following commands
    
Required: init -> This command is always safe to run multiple times, to bring the working directory up to date with changes in the configuration.
Though subsequent runs may give errors, this command will never delete your existing configuration or state.

    terraform init
    
Required: plan -> This command is a convenient way to check whether the execution plan for a set of changes
matches your expectations without making any changes to real resources or to the state. For example, terraform plan might be
run before committing a change to version control, to create confidence that it will behave as expected.

     terraform plan -var-file=creds/secret.tfvars

Required: apply -> By default, apply scans the current directory for the configuration and applies the changes appropriately.
However, a path to another configuration or an execution plan can be provided. Explicit execution plans files can be used to split
plan and apply into separate steps within automation systems.

    terraform apply -var-file=creds/secret.tfvars

Optional: destroy -> To delete the entire infrastructure and data.

    terraform destroy -var-file=creds/secret.tfvars
    
TODO

  * Add output for all the hostname + add Jira IP into RDS VPC (manual step for now)
  * Jenkins userscript to set up docker compose
  * Configure docker machine with terraform
