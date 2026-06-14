resource "oci_core_instance" "linux_vm" {

  count = var.instance_count

  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain

  display_name = "${var.instance_name_prefix}-${count.index + 1}"

  shape = var.instance_shape

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"

    source_id = data.oci_core_images.autonomous_linux.images[0].id

    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }

  preemptible_instance_config {
    preemption_action {
      type                 = "TERMINATE"
      preserve_boot_volume = false
    }
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key

    user_data = base64encode(templatefile("${path.module}/cloud-init.sh", {
      node_exporter_version = var.node_exporter_version
    }))
  }
}
