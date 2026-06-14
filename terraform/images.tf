data "oci_core_images" "autonomous_linux" {
  compartment_id = var.compartment_ocid

  operating_system         = "Oracle Autonomous Linux"
  operating_system_version = "9"

  shape = var.instance_shape

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}
