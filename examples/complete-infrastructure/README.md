# Complete Infrastructure Example

This example demonstrates a complete, production-ready infrastructure setup with multiple AWS services working together.

## Architecture

This example creates a complete infrastructure stack including:

- **Networking**: VPC, subnets, route tables, internet gateway
- **Storage**: S3 buckets for application data and logs
- **Compute**: (Template - add EC2/ECS/Lambda as needed)
- **Security**: Security groups, IAM roles, policies
- **Monitoring**: (Template - add CloudWatch as needed)

## What This Example Shows

1. **Multi-Service Integration**: Multiple AWS services working together
2. **Network Architecture**: Proper VPC setup with public/private subnets
3. **Security Best Practices**: Least privilege access, encryption, security groups
4. **High Availability**: Multi-AZ deployment patterns
5. **Environment Separation**: Different configurations per environment

## Usage

```bash
# Initialize
terraform init

# Review plan for dev environment
terraform plan -var-file="../../environments/dev/dev.tfvars"

# Review plan for production
terraform plan -var-file="../../environments/prod/prod.tfvars"

# Apply
terraform apply -var-file="../../environments/dev/dev.tfvars"
```

## Components

### Storage Layer
- Application data bucket (S3) with versioning and encryption
- Logs bucket (S3) with lifecycle policies

### (Additional components can be added here)
- VPC with public and private subnets
- NAT Gateway for private subnet internet access
- Security groups for access control
- EC2 instances or containers
- Load balancers
- Databases (RDS)

## Best Practices

1. **Modular Design**: Each component in its own module
2. **Environment Configuration**: Use tfvars for environment-specific settings
3. **Security by Default**: Encryption, private subnets, security groups
4. **Tagging Strategy**: Consistent tagging across all resources
5. **Documentation**: Inline comments and README files

## Cost Considerations

- **Dev Environment**: Optimized for cost (~$10-50/month)
- **Prod Environment**: Optimized for availability (~$100-500/month)

Actual costs depend on:
- Instance types and counts
- Data transfer
- Storage usage
- NAT Gateway usage

## Extending This Example

You can extend this example by adding:

1. **Compute Layer**: EC2, ECS, EKS, Lambda
2. **Database Layer**: RDS, DynamoDB, ElastiCache
3. **CDN**: CloudFront distributions
4. **DNS**: Route53 zones and records
5. **Monitoring**: CloudWatch dashboards and alarms
6. **CI/CD**: CodePipeline, CodeBuild

## Cleanup

```bash
terraform destroy -var-file="../../environments/dev/dev.tfvars"
```

**Note**: Always review the destroy plan before confirming!
