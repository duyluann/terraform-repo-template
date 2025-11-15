# Terraform Examples

This directory contains example Terraform configurations demonstrating best practices and common patterns.

## Available Examples

### 1. Data Sources (`data-sources/`)
Demonstrates how to query existing AWS resources using data sources.

- VPC and subnet lookups
- AMI queries
- Availability zones
- AWS account information

### 2. Module Composition (`module-composition/`)
Shows how to compose multiple modules together for complex infrastructure.

- Using multiple custom modules
- Passing outputs between modules
- Module dependencies

### 3. Complete Infrastructure (`complete-infrastructure/`)
A complete example showing a realistic infrastructure setup.

- VPC with public/private subnets
- EC2 instances with security groups
- S3 buckets for storage
- All components working together

## Using Examples

Each example is self-contained and can be used as a reference or starting point:

```bash
# Navigate to an example
cd examples/data-sources

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply (if desired)
terraform apply
```

## Best Practices Demonstrated

1. **Module Usage**: Proper module structure and composition
2. **Data Sources**: Querying existing infrastructure
3. **Variables**: Input validation and sensible defaults
4. **Outputs**: Exposing useful information
5. **Locals**: DRY principle and computed values
6. **Tagging**: Consistent resource tagging
7. **Security**: Security best practices
8. **Documentation**: Comprehensive inline documentation

## Note

These examples use default AWS provider configuration. You may need to:
- Configure AWS credentials
- Adjust regions and availability zones
- Modify resource names to avoid conflicts
- Review and adjust for your specific use case
