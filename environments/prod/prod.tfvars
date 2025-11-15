# Production Environment Configuration
# Best practice: High availability, security, and monitoring enabled

env    = "prod"
region = "ap-southeast-1" # Southeast Asia (Singapore)
prefix = "myapp"

# Production-specific settings (examples)
# Enable all critical features for production workloads

# Example: Enable/disable features per environment
# enable_monitoring       = true
# enable_backup          = true
# enable_encryption      = true
# enable_deletion_protection = true

# Example: Instance sizing for production (HA configuration)
# instance_type  = "t3.medium"
# instance_count = 3  # For high availability

# Example: Database configuration
# db_instance_class      = "db.r6g.large"
# db_allocated_storage   = 100
# db_multi_az            = true   # High availability
# db_backup_retention    = 30     # 30 days retention

# Example: Network configuration
# vpc_cidr             = "10.2.0.0/16"
# availability_zones   = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
# enable_nat_gateway   = true
# single_nat_gateway   = false  # NAT Gateway per AZ for HA

# Best practices for production environment:
# 1. Enable multi-AZ for high availability
# 2. Use appropriate instance sizing for workload
# 3. Enable comprehensive monitoring and alerting
# 4. Implement automated backups with long retention
# 5. Enable deletion protection on critical resources
# 6. Use encryption for data at rest and in transit
# 7. Implement proper tagging for cost allocation
# 8. Enable detailed CloudWatch logs and metrics
