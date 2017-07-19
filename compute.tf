resource "baremetal_core_instance" "murphy_TFPOC_Instance01" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "murphy_TFPOC_Instance01"
  image = "${lookup(data.baremetal_core_images.OLImageOCID.images[0], "id")}"
  shape = "${var.InstanceShape}"
  subnet_id = "${baremetal_core_subnet.murphy-PublicSubnetAD1.id}"
  metadata {
#    ssh_authorized_keys = "${var.ssh_public_key}"
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
    user_data = "${base64encode(var.user-data)}"
  }

  timeouts {
    create = "60m"
  }
}


resource "baremetal_core_instance" "murphy_TFPOC_Instance02" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "murphy_TFPOC_Instance02"
  image = "${lookup(data.baremetal_core_images.OLImageOCID.images[0], "id")}"
  shape = "${var.InstanceShape}"
  subnet_id = "${baremetal_core_subnet.murphy-PublicSubnetAD2.id}"
  metadata {
#    ssh_authorized_keys = "${var.ssh_public_key}"
    ssh_authorized_keys = "${file(var.ssh_public_key_path)}"
    user_data = "${base64encode(var.user-data)}"
  }

  timeouts {
    create = "60m"
  }
}
