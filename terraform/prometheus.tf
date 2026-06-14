resource "local_file" "prometheus_config" {
  content = templatefile(
    "${path.module}/../dashboard/prometheus/prometheus.yml.tpl",
    {
      targets = [
        for instance in oci_core_instance.linux_vm :
        {
          name       = instance.display_name
          public_ip  = instance.public_ip
          private_ip = instance.private_ip
          id         = instance.id
        }
      ]
    }
  )

  filename = "${path.module}/../dashboard/prometheus/prometheus.yml"
}
