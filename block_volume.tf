resource "oci_core_volume" "data_volume" {

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid

  display_name = "data-volume"

  size_in_gbs = 50

  vpus_per_gb = 10
}

resource "oci_core_volume_attachment" "data_volume_attachment" {

  attachment_type = "paravirtualized"

  instance_id = oci_core_instance.linux_vm[0].id
  volume_id   = oci_core_volume.data_volume.id
}