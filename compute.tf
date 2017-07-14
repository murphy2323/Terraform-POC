resource "baremetal_core_instance" "murphy_TFPOC_Instance" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "murphy_TFPOC_Instance"
  #hostname_label = "instance1"
  image = "${lookup(data.baremetal_core_images.OLImageOCID.images[0], "id")}"
  shape = "${var.InstanceShape}"
  subnet_id = "${baremetal_core_subnet.murphy-PublicSubnetAD1.id}"
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

  timeouts {
    create = "60m"
  }
}
