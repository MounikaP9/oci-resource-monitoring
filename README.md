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

# OCI Resource Monitoring

Infrastructure and monitoring solution built on Oracle Cloud Infrastructure (OCI).

## Components

### Terraform

Provision OCI resources:

* VCN
* Subnet
* Internet Gateway
* Security Lists
* Compute Instance
* Block Volume

### Monitoring Stack

Prometheus + Grafana

Metrics collected:

* CPU Usage
* Memory Usage
* Disk Usage
* Filesystem Utilization
* Network Traffic
* System Load

### Architecture

OCI Compute Instance
→ Node Exporter
→ Prometheus
→ Grafana Dashboard

### Project Structure

terraform/

* OCI infrastructure code

dashboard/

* Prometheus configuration
* Grafana provisioning
* Dashboard definitions

## Run Monitoring Stack

cd dashboard

docker compose up -d

Grafana:
http://localhost:3000

Prometheus:
http://localhost:9090

## Future Enhancements

* Multi-instance monitoring
* Alertmanager integration
* OCI Monitoring API integration
* Email and Slack alerts


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
