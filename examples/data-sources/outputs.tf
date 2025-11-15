# Example outputs from data sources

output "account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "Current AWS region"
  value       = data.aws_region.current.name
}

output "availability_zones" {
  description = "List of available AZs in the region"
  value       = data.aws_availability_zones.available.names
}

output "default_vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}

output "default_vpc_cidr" {
  description = "Default VPC CIDR block"
  value       = data.aws_vpc.default.cidr_block
}

output "default_subnets" {
  description = "Default subnet IDs"
  value       = data.aws_subnets.default.ids
}

output "amazon_linux_2_ami" {
  description = "Latest Amazon Linux 2 AMI ID"
  value       = data.aws_ami.amazon_linux_2.id
}

output "amazon_linux_2_ami_name" {
  description = "Latest Amazon Linux 2 AMI name"
  value       = data.aws_ami.amazon_linux_2.name
}

output "ubuntu_ami" {
  description = "Latest Ubuntu 22.04 AMI ID"
  value       = data.aws_ami.ubuntu.id
}

output "ubuntu_ami_name" {
  description = "Latest Ubuntu 22.04 AMI name"
  value       = data.aws_ami.ubuntu.name
}
