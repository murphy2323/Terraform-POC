/*
 * This example demonstrates basic load balancer configuration and requires an existing instance and subnets.
 * It should be configured with a proper cert.crt and cert.key for ssl configuration, but dummy certs are
 * included for demonstration purposes.
 */

/* Load Balancer */

resource "baremetal_load_balancer" "lb1" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"
  subnet_ids     = [
    "${baremetal_core_subnet.murphy-PublicSubnetAD1.id}",
    "${baremetal_core_subnet.murphy-PublicSubnetAD2.id}"
  ]
  display_name   = "murphy_TFPOC_lb1"
}

resource "baremetal_load_balancer_backendset" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = "${baremetal_load_balancer.lb1.id}"
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
  }
}

resource "baremetal_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${baremetal_load_balancer.lb1.id}"
  name                     = "https"
  default_backend_set_name = "${baremetal_load_balancer_backendset.lb-bes1.id}"
  port                     = 443
  protocol                 = "HTTP"

  ssl_configuration {
    certificate_name        = "${baremetal_load_balancer_certificate.lb-cert1.certificate_name}"
    verify_peer_certificate = false
  }
}

resource "baremetal_load_balancer_listener" "lb-listener2" {
  load_balancer_id         = "${baremetal_load_balancer.lb1.id}"
  name                     = "http"
  default_backend_set_name = "${baremetal_load_balancer_backendset.lb-bes1.id}"
  port                     = 80
  protocol                 = "HTTP"
}


resource "baremetal_load_balancer_backend" "lb-be1" {
  load_balancer_id = "${baremetal_load_balancer.lb1.id}"
  backendset_name  = "${baremetal_load_balancer_backendset.lb-bes1.id}"
  ip_address       = "${baremetal_core_instance.murphy_TFPOC_Instance01.private_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "baremetal_load_balancer_backend" "lb-be2" {
  load_balancer_id = "${baremetal_load_balancer.lb1.id}"
  backendset_name  = "${baremetal_load_balancer_backendset.lb-bes1.id}"
  ip_address       = "${baremetal_core_instance.murphy_TFPOC_Instance02.private_ip}"
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}




resource "baremetal_load_balancer_certificate" "lb-cert1" {
  load_balancer_id   = "${baremetal_load_balancer.lb1.id}"
  certificate_name   = "certificate1"
  ca_certificate     = ""
  public_certificate = "${file("${path.module}/cert.crt")}"
  private_key        = "${file("${path.module}/cert.key")}"
}
