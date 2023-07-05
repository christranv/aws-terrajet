
output "id" {
  description = "The ID of the instance"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].spot_instance_id : aws_instance.instance[0].id
}

output "arn" {
  description = "The ARN of the instance"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].arn : aws_instance.instance[0].arn
}

output "capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].capacity_reservation_specification : aws_instance.instance[0].capacity_reservation_specification
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].instance_state : aws_instance.instance[0].instance_state
}

output "outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].outpost_arn : aws_instance.instance[0].outpost_arn
}

output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].password_data : aws_instance.instance[0].password_data
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].primary_network_interface_id : aws_instance.instance[0].primary_network_interface_id
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].private_ip : aws_instance.instance[0].private_ip
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].private_dns : aws_instance.instance[0].private_dns
}

output "public_dns" {
  description = "The public DNS name from EIP assigned to the instance."
  value       = var.assign_public_ip ? aws_eip.eip[0].public_dns : null
}

output "ipv6_addresses" {
  description = "The IPv6 address assigned to the instance, if applicable."
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].ipv6_addresses : aws_instance.instance[0].ipv6_addresses
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = var.use_spot ? aws_spot_instance_request.spot-instance[0].tags_all : aws_instance.instance[0].tags_all
}
