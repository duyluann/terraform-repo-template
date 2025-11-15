# QA/Staging Environment Configuration
# Best practice: Mirror production configuration but with reduced capacity

env    = "qa"
region = "ap-southeast-1" # Southeast Asia (Singapore)
prefix = "myapp"

# QA-specific settings (examples)
# Should closely match production but with lower capacity

# Example: Enable/disable features per environment
# enable_monitoring = true
# enable_backup     = true
# enable_encryption = true

# Example: Instance sizing for QA (smaller than prod)
# instance_type  = "t3.small"
# instance_count = 2

# Example: Database configuration
# db_instance_class      = "db.t3.small"
# db_allocated_storage   = 50
# db_multi_az            = false  # Single AZ to save costs
# db_backup_retention    = 7

# Example: Network configuration
# vpc_cidr             = "10.1.0.0/16"
# availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
# enable_nat_gateway   = true
# single_nat_gateway   = true

# Best practices for QA environment:
# 1. Mirror production architecture but with reduced capacity
# 2. Enable monitoring and logging for testing
# 3. Use realistic data volumes for accurate testing
# 4. Enable backup/restore testing
# 5. Test disaster recovery procedures here
