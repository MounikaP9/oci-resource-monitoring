variable "compartment_ocid" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "instance_count" {
  description = "Number of OCI compute instances"
  type        = number
  default     = 1

  validation {
    condition     = var.instance_count > 0
    error_message = "instance_count must be greater than 0."
  }
}

variable "instance_name_prefix" {
  description = "Prefix used for OCI compute instance display names"
  type        = string
  default     = "monitoring-node"
}

variable "instance_shape" {
  description = "OCI compute shape for each instance"
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "instance_ocpus" {
  description = "OCPUs assigned to each flexible compute instance"
  type        = number
  default     = 1
}

variable "instance_memory_in_gbs" {
  description = "Memory in GB assigned to each flexible compute instance"
  type        = number
  default     = 4
}

variable "boot_volume_size_in_gbs" {
  description = "Boot volume size in GB for each compute instance"
  type        = number
  default     = 50
}

variable "vcn_cidr_block" {
  description = "CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ssh_ingress_cidr" {
  description = "CIDR range allowed to SSH into instances"
  type        = string
  default     = "0.0.0.0/0"
}

variable "node_exporter_ingress_cidr" {
  description = "CIDR range allowed to scrape Node Exporter on port 9100"
  type        = string
  default     = "0.0.0.0/0"
}

variable "node_exporter_version" {
  description = "Node Exporter version installed by cloud-init"
  type        = string
  default     = "1.9.1"
}
