# Development Environment Configuration
# Best practice: Use environment-specific values for resources, sizing, and features

env    = "dev"
region = "ap-southeast-1" # Southeast Asia (Singapore)
prefix = "myapp"

# Development-specific settings (examples)
# Uncomment and modify based on your infrastructure needs

# Example: Enable/disable features per environment
# enable_monitoring = false
# enable_backup     = false
# enable_encryption = true

# Example: Instance sizing for dev
# instance_type  = "t3.micro"
# instance_count = 1

# Example: Database configuration
# db_instance_class      = "db.t3.micro"
# db_allocated_storage   = 20
# db_multi_az            = false
# db_backup_retention    = 1

# Example: Network configuration
# vpc_cidr             = "10.0.0.0/16"
# availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
# enable_nat_gateway   = false
# single_nat_gateway   = true

# Best practices for dev environment:
# 1. Use smaller instance types to save costs
# 2. Disable expensive features (multi-AZ, backups)
# 3. Use shorter retention periods
# 4. Consider using spot instances
# 5. Enable deletion protection = false for easy cleanup
