output "instance_public_ips" {
  description = "Public IPs of all OCI instances"

  value = [
    for instance in oci_core_instance.linux_vm :
    instance.public_ip
  ]
}

output "instance_details" {
  description = "OCI compute instance names and IP addresses"

  value = [
    for instance in oci_core_instance.linux_vm :
    {
      name       = instance.display_name
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
      ocid       = instance.id
    }
  ]
}

output "prometheus_targets" {
  description = "Node Exporter scrape targets generated for Prometheus"

  value = [
    for instance in oci_core_instance.linux_vm :
    "${instance.display_name} = ${instance.public_ip}:9100"
  ]
}
