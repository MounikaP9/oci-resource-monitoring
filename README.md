# OCI Resource Monitoring Infrastructure

This project provisions OCI compute instances with Terraform and monitors their Linux host metrics with self-managed Prometheus, Node Exporter, and Grafana.

## What Terraform Creates

- VCN, public subnet, internet gateway, route table, and security list
- A configurable number of OCI compute instances
- Node Exporter on every instance through cloud-init
- A generated Prometheus config at `dashboard/prometheus/prometheus.yml`
- Terminal outputs with instance names, public IPs, private IPs, and OCIDs

## Configure Instance Count

Edit `terraform/terraform.tfvars`:

```hcl
instance_count       = 3
instance_name_prefix = "monitoring-node"
```

Optional values such as shape, OCPU, memory, boot volume size, VCN CIDR, subnet CIDR, SSH source CIDR, Node Exporter source CIDR, and Node Exporter version are defined in `terraform/variables.tf`.

## Create Instances

Run Terraform from the `terraform` directory:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

After `terraform apply`, Terraform prints outputs like:

```text
instance_details = [
  {
    name       = "monitoring-node-1"
    public_ip  = "x.x.x.x"
    private_ip = "10.0.1.x"
    ocid       = "ocid1.instance..."
  }
]
```

Terraform also writes the Prometheus scrape targets automatically, so instance IPs are not hardcoded in the dashboard stack.

## Run Prometheus And Grafana

After applying Terraform:

```bash
cd ../dashboard
docker compose up -d
```

Open:

- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090

Grafana login:

- Username: `admin`
- Password: `admin`

The provisioned dashboard is named `OCI Resource Monitoring`.

## Metrics In The Dashboard

The dashboard uses Node Exporter metrics for:

- CPU usage
- RAM usage
- Root filesystem usage
- Filesystem usage by mount point
- Network receive/transmit throughput
- System load
- Node Exporter health

## Add Or Remove Instances

Change `instance_count` in `terraform/terraform.tfvars`, then run:

```bash
cd terraform
terraform apply
```

Terraform will create or remove instances to match the requested count and regenerate `dashboard/prometheus/prometheus.yml`.

Restart Prometheus after the target file changes:

```bash
cd ../dashboard
docker compose restart prometheus
```

## Terminate Everything In One Command

Run:

```bash
cd terraform
terraform destroy
```

This terminates the OCI instances and destroys the Terraform-managed network resources.

## Notes

- OCI Free Tier capacity limitations may prevent instance creation in some regions.
- Restrict `ssh_ingress_cidr` and `node_exporter_ingress_cidr` to trusted IP ranges for production use.
- You still pay OCI infrastructure costs for compute, boot volumes, block volumes, storage, and any applicable network usage.
