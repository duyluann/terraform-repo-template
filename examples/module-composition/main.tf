# Example: Module Composition
# Best practice: Compose multiple modules to build complex infrastructure

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Example     = "module-composition"
    }
  }
}

# Use the S3 module
module "application_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name       = "${var.prefix}-${var.environment}-app-data"
  environment       = var.environment
  enable_versioning = var.environment == "prod" ? true : false
  enable_encryption = true

  lifecycle_rules = var.environment == "prod" ? [
    {
      id                       = "archive-old-files"
      enabled                  = true
      transition_days          = 90
      transition_storage_class = "GLACIER"
      expiration_days          = null
    }
  ] : []

  tags = {
    Purpose = "Application Data"
  }
}

# Another S3 bucket for logs
module "logs_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name       = "${var.prefix}-${var.environment}-logs"
  environment       = var.environment
  enable_versioning = false
  enable_encryption = true

  lifecycle_rules = [
    {
      id                       = "delete-old-logs"
      enabled                  = true
      expiration_days          = 30
      transition_days          = null
      transition_storage_class = null
    }
  ]

  tags = {
    Purpose = "Application Logs"
  }
}

# Example: Using outputs from one module as inputs to another
# This demonstrates module dependency and composition

locals {
  bucket_info = {
    app_bucket  = module.application_bucket.bucket_id
    logs_bucket = module.logs_bucket.bucket_id
  }
}

# Best practices demonstrated:
# 1. Reuse modules with different configurations
# 2. Use conditional logic for environment-specific settings
# 3. Pass outputs between modules
# 4. Use locals to organize module outputs
# 5. Apply environment-specific lifecycle rules
