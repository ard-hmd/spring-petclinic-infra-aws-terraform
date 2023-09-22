# Spring PetClinic Infrastructure Deployment on AWS with Terraform

## Introduction

Welcome to the infrastructure-as-code (IaC) repository for deploying the [Spring PetClinic Cloud application](https://github.com/spring-petclinic/spring-petclinic-cloud) on AWS using Kubernetes (K8s) and Terraform. This repository provides a comprehensive solution to set up a robust, scalable, and secure environment tailored for the PetClinic application.

## Key Features

- **Modular Design**: The infrastructure is built using modular Terraform code, making it flexible and reusable.
- **Scalability**: Leveraging AWS services and Kubernetes, this setup ensures that the application can handle varying loads and can be easily scaled up or down.
- **Security**: With security groups, IAM roles, and other AWS security features, the infrastructure is designed to be secure out of the box. However, always ensure to follow best practices and review configurations based on your specific requirements.
- **High Availability**: The use of multi-AZ deployments, replicas, and other AWS services ensures high availability and fault tolerance.

Before diving into the deployment steps, it's essential to understand the architecture, prerequisites, and the various components involved. This documentation will guide you through the entire process, from initial setup to deployment, ensuring a transparent deployment experience.

## Initial Setup

Before deploying the infrastructure, it's crucial to set up your environment. Follow the steps below to properly configure your workspace:

1. **Version Control**: Ensure you are using the latest version of the main repository. For the AWS provider, version 5.0 is recommended. Consider adding a `version.tf` file to specify and lock the Terraform and provider versions.

2. **AWS IAM User**: Ensure you have an AWS IAM user with programmatic access. This user will be used to interact with AWS services via Terraform.

3. **Clone the Repository**: 
   ```bash
   git clone https://github.com/ard-hmd/spring-petclinic-infra-aws-terraform.git
   ```

4. **Navigate to the Repository Directory:**
   ```bash
   cd spring-petclinic-infra-aws-terraform
   ```

5. **Create a `secrets.tfvars` file:**
   Create a new file named `secrets.tfvars` in the root directory of the cloned repository. Add the following content to this file:
   ```hcl
   customersdb_password = "password"
   vetsdb_password      = "password"
   visitsdb_password    = "password"
   ```

## Configuration Variables

Terraform uses variables to parameterize and customize the deployment of the infrastructure. Here's a list of the most pertinent variables you might want to adjust:

### [Main Repository](https://github.com/ard-hmd/spring-petclinic-infra-aws-terraform)

- **vpc_cidr**: CIDR block for the VPC. Default: `"10.0.0.0/16"`.
- **environment**: The environment for which the infrastructure is being deployed (e.g., prod, dev, staging). Default: `"dev"`.
- **aws_region**: The AWS region in which to deploy the infrastructure. Default: `"eu-west-3"`.

### [VPC Module](https://github.com/ard-hmd/terraform-aws-vpc)

- **vpc_name**: Name of the VPC. Default: `"my-vpc"`.
- **public_subnet_cidrs**: CIDR blocks for the public subnets. Default: `["10.0.1.0/24", "10.0.2.0/24"]`.
- **private_subnet_cidrs**: CIDR blocks for the private subnets. Default: `["10.0.3.0/24", "10.0.4.0/24"]`.

### [EKS Cluster Module](https://github.com/ard-hmd/terraform-aws-eks-cluster)

- **cluster_name**: Name of the EKS cluster. Default: `"my-cluster"`.
- **cluster_version**: Version of the EKS cluster. Default: `"1.21"`.
- **node_group_name**: Name of the EKS node group. Default: `"my-node-group"`.

### [EKS Node Group Module](https://github.com/ard-hmd/terraform-aws-eks-nodegroup)

- **node_group_name**: Name of the EKS node group. Default: `"my-node-group"`.
- **disk_size**: Disk size for the EKS nodes. Default: `20`.

### [RDS Module](https://github.com/ard-hmd/terraform-aws-rds)

- **allocated_storage**: Allocated storage space for the RDS database. Default: `10`.
- **engine_version**: Engine version of the RDS database. Default: `"5.7"`.
- **instance_class**: Instance class for the RDS database. Default: `"db.t3.micro"`.

### [RDS Replica Module](https://github.com/ard-hmd/terraform-aws-rds-replica)

- **instance_class**: Instance class for the RDS replica. Default: `"db.t3.micro"`.
- **replicate_source_db**: The source RDS instance to replicate. Default: `"source-db-name"`.

These variables can be set in a `tfvars` file or passed directly when running the `terraform plan` or `terraform apply` commands. For a complete list of variables and their default values, please refer to the `vars.tf` files in the main repository and the modules.


## Deployment

Once you've completed the initial configuration, you can proceed with the deployment of the infrastructure. Follow the steps below:

1. **Plan the Deployment:**
   ```bash
   terraform plan -var-file=secrets.tfvars
   ```

2. **Apply the Changes:**
   ```bash
   terraform apply -var-file=secrets.tfvars
   ```

## Destruction

After testing and utilizing the infrastructure, if you wish to tear it down to avoid any additional costs or for other reasons, follow the steps below:

1. **Navigate to the Repository Directory**:
   Ensure you're in the main directory of the repository.
   ```bash
   cd spring-petclinic-infra-aws-terraform
   ```

2. **Plan the Destruction**:
   It's always good to first plan the destruction to see which resources will be removed.
   ```bash
   terraform plan -destroy -var-file=secrets.tfvars
   ```

3. **Destroy the Infrastructure**:
   Run the following command to destroy all the resources created by Terraform. Be very cautious as this action is irreversible.
   ```bash
   terraform destroy -var-file=secrets.tfvars
   ```

**Warning**: Destroying the infrastructure will remove all associated AWS resources, including databases, clusters, etc. Ensure you have backed up any critical data before proceeding.

