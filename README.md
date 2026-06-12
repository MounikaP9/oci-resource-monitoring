# OCI Resource Monitoring Infrastructure

## Overview

This project uses Terraform to provision Oracle Cloud Infrastructure (OCI) resources.

## Resources Created

- Virtual Cloud Network (VCN)
- Public Subnet
- Internet Gateway
- Route Table
- Security List
- Compute Instance

## Technologies Used

- Oracle Cloud Infrastructure (OCI)
- Terraform
- OCI CLI
- GitHub

## Project Structure

```text
compute.tf
network.tf
provider.tf
variables.tf
terraform.tfvars
images.tf
```

## Usage

Initialize Terraform:

```bash
terraform init
```

Preview changes:

```bash
terraform plan
```

Deploy resources:

```bash
terraform apply
```

## Notes

OCI Free Tier capacity limitations may prevent instance creation in some regions.
