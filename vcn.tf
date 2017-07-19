resource "baremetal_core_virtual_network" "murphy_TFPOC_Network" {
  cidr_block = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "Murphy_TFPOC Network"
}

resource "baremetal_core_internet_gateway" "murphy_TFPOC_Internet_Gateway" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Murphy_TFPOC Internet Gateway"
    vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"
}

resource "baremetal_core_route_table" "murphy_TFPOC_RouteTable" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"
    display_name = "Murphy_TFPOC Route Table"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${baremetal_core_internet_gateway.murphy_TFPOC_Internet_Gateway.id}"
    }
}

resource "baremetal_core_security_list" "murphy_TFPOC_SecurityList" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Murphy_TFPOC Security List"
    vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"

    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "all"
    }]

    ingress_security_rules = [
    {
        tcp_options {
            "max" = 80
            "min" = 80
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        tcp_options {
            "max" = 443
            "min" = 443
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
    {
        tcp_options {
            "max" = 9092
            "min" = 9092
        }
        protocol = "6"
        source = "10.0.0.0/24"
    },
    {
        tcp_options {
            "max" = 9092
            "min" = 9092
        }
        protocol = "6"
        source = "10.0.1.0/24"
    },
    {
        tcp_options {
            "max" = 9092
            "min" = 9092
        }
        protocol = "6"
        source = "10.0.2.0/24"
    }
    ]
}

resource "baremetal_core_subnet" "murphy-PublicSubnetAD1" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "10.1.20.0/24"
  display_name = "murphy-Public Subnet AD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"
  route_table_id = "${baremetal_core_route_table.murphy_TFPOC_RouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.murphy_TFPOC_SecurityList.id}"]
  #dns_label = "vcn1"
  #dhcp_options_id = "ocid1.dhcpoptions.oc1.phx.aaaaaaaa5sov4gfpfmtwy3iunnipco664wmd6r2zdktfkkglygyioh2mxwpq"
  dhcp_options_id     = "${baremetal_core_virtual_network.murphy_TFPOC_Network.default_dhcp_options_id}"
}

resource "baremetal_core_subnet" "murphy-PublicSubnetAD2" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block = "10.1.21.0/24"
  display_name = "murphy-Public Subnet AD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"
  route_table_id = "${baremetal_core_route_table.murphy_TFPOC_RouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.murphy_TFPOC_SecurityList.id}"]
  #dns_label = "vcn2"
  #dhcp_options_id = "ocid1.dhcpoptions.oc1.phx.aaaaaaaa5sov4gfpfmtwy3iunnipco664wmd6r2zdktfkkglygyioh2mxwpq"
  dhcp_options_id     = "${baremetal_core_virtual_network.murphy_TFPOC_Network.default_dhcp_options_id}"

}

resource "baremetal_core_subnet" "murphy-PublicSubnetAD3" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "10.1.22.0/24"
  display_name = "murphy-Public Subnet AD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${baremetal_core_virtual_network.murphy_TFPOC_Network.id}"
  route_table_id = "${baremetal_core_route_table.murphy_TFPOC_RouteTable.id}"
  security_list_ids = ["${baremetal_core_security_list.murphy_TFPOC_SecurityList.id}"]
  #dns_label = "vcn3"
  #dhcp_options_id = "ocid1.dhcpoptions.oc1.phx.aaaaaaaa5sov4gfpfmtwy3iunnipco664wmd6r2zdktfkkglygyioh2mxwpq"
  dhcp_options_id     = "${baremetal_core_virtual_network.murphy_TFPOC_Network.default_dhcp_options_id}"

}
