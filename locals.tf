# Local values for resource naming and common configurations
# Best practice: Use locals to avoid repetition and ensure consistency

locals {
  # Resource naming convention: {prefix}-{environment}-{resource-type}-{name}
  resource_prefix = var.prefix != "" ? "${var.prefix}-${var.env}" : var.env

  # Common tags to merge with provider default_tags
  # These will be combined with the default_tags in providers.tf
  common_tags = {
    Terraform   = "true"
    Project     = "terraform-template"
    ManagedBy   = "Terraform"
    Environment = var.env
    Region      = var.region
  }

  # Naming patterns - Use these for consistent resource names
  # Example usage: name = "${local.name_prefix}-vpc"
  name_prefix = local.resource_prefix

  # Environment-specific configurations
  is_production = var.env == "prod"
  is_dev        = var.env == "dev"

  # Example: Different settings per environment
  instance_count = local.is_production ? 3 : 1
  enable_backup  = local.is_production ? true : false

  # Example: Cost allocation tags
  cost_center = var.env == "prod" ? "production-ops" : "development"
}

# Best practices for locals:
# 1. Use locals for computed values and DRY principle
# 2. Avoid complex logic - use variables or data sources instead
# 3. Group related locals together
# 4. Document purpose with comments
# 5. Use locals for naming conventions to ensure consistency
