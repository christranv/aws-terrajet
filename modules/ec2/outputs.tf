
output "id" {
  description = "The ID of the instance"
  value       = aws_instance.this.id
}

output "arn" {
  description = "The ARN of the instance"
  value       = aws_instance.this.arn
}

output "capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance"
  value       = aws_instance.this.capacity_reservation_specification
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = aws_instance.this.instance_state
}

output "outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value       = aws_instance.this.outpost_arn
}

output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = aws_instance.this.password_data
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = aws_instance.this.primary_network_interface_id
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = aws_instance.this.private_ip
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.this.private_dns
}

output "public_ip" {
  description = "The public DNS name from EIP assigned to the instance."
  value       = var.assign_public_ip ? aws_eip.eip[0].public_ip : null
}

output "public_dns" {
  description = "The public DNS name from EIP assigned to the instance."
  value       = var.assign_public_ip ? aws_eip.eip[0].public_dns : null
}
