resource "oci_core_instance" "linux_vm" {

  count = 1

  compartment_id      = var.compartment_ocid
  availability_domain = var.availability_domain

  display_name = "linux-vm-${count.index + 1}"

shape = "VM.Standard.A1.Flex"

shape_config {
  ocpus         = 1
  memory_in_gbs = 2
}

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    assign_public_ip = true
  }

  source_details {
  source_type = "image"

  source_id = data.oci_core_images.oracle_linux_a1.images[0].id

  boot_volume_size_in_gbs = 50
}

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}

