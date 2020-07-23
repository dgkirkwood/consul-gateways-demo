# Consul Gateways Demo
This code creates a demonstration environment to show the usage of Consul service mesh with mesh, terminating and ingress gateways. 



## Pre-requirements 

* Install Terraform 0.12 or higher

* Ensure you have a AWS and a GCP account

* Install helm 3

* Install Kubectl

* Install aswcli v2 https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html 

* Install GKE SDK https://cloud.google.com/sdk/docs/downloads-interactive 

* Clone this repo




## Usage
### 1. Inputs

### AWS 

Open the file Cluster_EKS/variables.tf

You will need to set the following variables to be relevant to your envrioment:
```hcl
variable "aws_region" 
```
### GCP

Open the file Cluster_GKE/variables.tf

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
### 2. Environment Variables

Ensure you have the correct environment variables set to auth to AWS and GCP

### 3. Terraform

Initialise your environment
```hcl
terraform init 
```

Run a Terraform plan
```hcl
terraform plan 
```

Apply the Terraform environment
```hcl
terraform apply
```

If the run is successful you will see a single output of an IP address we will use in the next step. 


### 4. Application

#### Initial Deploy
As part of the Terraform run you will now have two Kubernetes clusters that have been authenticated to your local Kubectl. 
Please note that you will need to ensure that Kubectl does not have multiple contexts available with the same naming convention as this can affect the scripts run in this step. Ensure if you run this environment multiple times that you remove the old contexts from Kubectl. 

To install the application, first check the file at app/gke_app/gke_app.yaml
On line 101 note the line 
```yaml
image: dgkirkwood/frontend:4.1
```
This is the container image that will change as you update the application. Ensure it is set to 4.1 to start the demo. 

Run the following script: app/01_initial_deploy.sh

This wil install Consul across GKE and EKS, federate the two and install the initial application elements. 


## Clean up

To delete your enviroments you need to run

./3.clean.sh in the main directory

then run terraform destroy

To clean up you will want to remove the user profile from your kubeconfig


