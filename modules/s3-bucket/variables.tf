# Module variables
# Best practice: Always include description, type, and validation where appropriate

variable "bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{1,61}[a-z0-9])?$", var.bucket_name)) && !can(regex("[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}", var.bucket_name)) && !can(regex("--", var.bucket_name))
    error_message = "Bucket name must be 3-63 chars, start/end with lowercase letter or number, contain only lowercase letters/numbers/hyphens, no consecutive hyphens, and cannot be formatted as an IP address."
  }
}

variable "environment" {
  description = "Environment name (dev, qa, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "Environment must be dev, qa, or prod."
  }
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "enable_encryption" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the bucket"
  type = list(object({
    id                       = string
    enabled                  = bool
    expiration_days          = optional(number)
    transition_days          = optional(number)
    transition_storage_class = optional(string)
    abort_incomplete_days    = optional(number)
  }))
  default = []
}

# Best practices for variables:
# 1. Always include description for documentation
# 2. Specify type constraints
# 3. Use validation blocks for input validation
# 4. Provide sensible defaults where appropriate
# 5. Use optional() for complex types (Terraform 1.3+)
# 6. Group related variables together
