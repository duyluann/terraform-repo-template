# Main Terraform Configuration
# This is the root module that orchestrates all infrastructure components

# Example usage of the S3 bucket module
# Uncomment and modify to create actual resources

# module "app_bucket" {
#   source = "./modules/s3-bucket"
#
#   bucket_name       = "${local.name_prefix}-app-data-${data.aws_caller_identity.current.account_id}"
#   environment       = var.env
#   enable_versioning = local.is_production
#   enable_encryption = true
#
#   lifecycle_rules = local.is_production ? [
#     {
#       id                       = "archive-old-data"
#       enabled                  = true
#       transition_days          = 90
#       transition_storage_class = "GLACIER"
#       expiration_days          = null
#     }
#   ] : []
#
#   tags = merge(
#     local.common_tags,
#     {
#       Purpose = "Application Data Storage"
#     }
#   )
# }

# Get current AWS account ID for unique bucket naming
data "aws_caller_identity" "current" {}

# Example: Create multiple resources using the same module
# module "logs_bucket" {
#   source = "./modules/s3-bucket"
#
#   bucket_name       = "${local.name_prefix}-logs-${data.aws_caller_identity.current.account_id}"
#   environment       = var.env
#   enable_versioning = false
#   enable_encryption = true
#
#   lifecycle_rules = [
#     {
#       id                       = "delete-old-logs"
#       enabled                  = true
#       expiration_days          = 30
#       transition_days          = null
#       transition_storage_class = null
#     }
#   ]
#
#   tags = merge(
#     local.common_tags,
#     {
#       Purpose = "Application Logs"
#     }
#   )
# }

# Best practices:
# 1. Keep root module clean and focused on orchestration
# 2. Use modules for reusable components
# 3. Pass variables from root to modules
# 4. Use locals for computed values and DRY principle
# 5. Document the purpose of each resource/module
# 6. Use data sources for dynamic values (account ID, region, etc.)
