# Gets a list of Availability Domains
data "baremetal_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Gets the OCID of the OS image to use
data "baremetal_core_images" "OLImageOCID" {
    compartment_id = "${var.compartment_ocid}"
    operating_system = "${var.InstanceOS}"
    operating_system_version = "${var.InstanceOSVersion}"
}
