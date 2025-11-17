# Root-level outputs
# These outputs expose key information from your infrastructure
# Best practice: Document what each output represents and its use case

# output "example_module_output" {
#   description = "Output from s3-bucket module"
#   value       = module.s3_bucket.example_output
# }

# Example: VPC ID (uncomment and modify when you create VPC resources)
# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = module.networking.vpc_id
# }

# Example: Application endpoint (uncomment and modify when you create ALB/API Gateway)
# output "application_endpoint" {
#   description = "The endpoint URL for the application"
#   value       = module.application.endpoint
# }

# Example: Environment information
output "environment" {
  description = "The environment name"
  value       = var.env
}

output "region" {
  description = "The AWS region where resources are deployed"
  value       = var.region
}

# Example: Resource naming prefix
output "resource_prefix" {
  description = "The prefix used for resource naming"
  value       = local.resource_prefix
}

# Best practices for outputs:
# 1. Always include a description
# 2. Use sensitive = true for secrets/credentials
# 3. Group related outputs together
# 4. Export ARNs, IDs, and endpoints that other teams/modules might need
# 5. Consider using output modules for complex scenarios
