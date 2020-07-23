# Consul Gateways Demo
This code creates a demonstration environment to show the usage of Consul service mesh with mesh, terminating and ingress gateways. 



## Pre-requirements 
Before you run this you will need to:

1.You will need to auth to GCP,Azure and AWS

2.Install helm 3

3.Install aswcli v2 https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html 

4.Install GKE SDK https://cloud.google.com/sdk/docs/downloads-interactive 

6.Clone this repo

7.Run terraform init


## Usage
### 1. Inputs

### EKS
You will need to set the following variables to be relevant to your envrioment:
```hcl
variable "aws_region" 
```
### GKE
You will need to set the following variables to be relevant to your envrioment:
```hcl
variable "gcp_region" 

  description = "GCP region, e.g. us-east1"
  
  default     = "australia-southeast1"

variable "gcp_zone" 

  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  
  default     = "australia-southeast1-c"

variable "gcp_project" 

  description = "GCP project name"
  
  default     = "your-project-name"
```

### Main.tf
Here you can name the clusters by altering the following:

```hcl
cluster_name = "your-name"
```




## Clean up

To delete your enviroments you need to run

./3.clean.sh in the main directory

then run terraform destroy

To clean up you will want to remove the user profile from your kubeconfig


