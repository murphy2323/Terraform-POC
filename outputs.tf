# Output the private and public IPs of the instance

output "Instance01PrivateIP" {
value = ["${baremetal_core_instance.murphy_TFPOC_Instance01.private_ip}"]
}

output "Instance01PublicIP" {
value = ["${baremetal_core_instance.murphy_TFPOC_Instance01.public_ip}"]
}


output "Instance02PrivateIP" {
value = ["${baremetal_core_instance.murphy_TFPOC_Instance02.private_ip}"]
}

output "Instance02PublicIP" {
value = ["${baremetal_core_instance.murphy_TFPOC_Instance02.public_ip}"]
}

output "lb_public_ip" {
  value = ["${baremetal_load_balancer.lb1.ip_addresses}"]
}
