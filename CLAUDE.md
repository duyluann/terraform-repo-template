# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Terraform project template designed for AWS infrastructure deployments with comprehensive CI/CD integration, security scanning, and best practices enforcement.

## Key Commands

### Local Development

```bash
# Install pre-commit hooks (REQUIRED before first commit)
pre-commit install

# Run pre-commit hooks manually on all files
pre-commit run --all-files

# Initialize Terraform
terraform init

# Format Terraform files
terraform fmt -recursive

# Validate Terraform configuration
terraform validate

# Run TFLint (with AWS plugin)
tflint --init  # First time only - downloads plugins
tflint --config=.tflint.hcl

# Run security scans
checkov --config-file .checkov.yml

# Plan for specific environment
terraform plan -var-file=environments/dev/dev.tfvars
terraform plan -var-file=environments/qa/qa.tfvars
terraform plan -var-file=environments/prod/prod.tfvars

# Apply for specific environment
terraform apply -var-file=environments/dev/dev.tfvars

# View outputs
terraform output

# Generate documentation
terraform-docs markdown table --output-file README.md .
```

## Architecture

### Version Management
- Terraform version constraint: >= 1.0 (versions.tf:2)
- AWS provider version: ~> 5.0 (versions.tf:5-8)
- `.terraform-version` file for tfenv/asdf version management
- Backend and version requirements consolidated in versions.tf

### Backend Configuration
- Default: Local backend for development (versions.tf)
- Production: S3 backend template available (commented in versions.tf)
- S3 backend requires: bucket, key, region, DynamoDB table, and encryption
- Note: backend.tf is deprecated - all configuration now in versions.tf

### Provider Setup
- AWS provider configured in providers.tf
- Default region: ap-southeast-1 (configurable via variables.tf)
- Auto-tagging: All resources tagged with `ManagedBy=Terraform` and `Environment`
- Additional tags can be merged via locals.tf

### Environment Structure
- Three environments: dev, qa, prod
- Environment-specific tfvars in `environments/{env}/{env}.tfvars`
- Each environment has different configurations:
  - **dev**: Cost-optimized, single instance, minimal features
  - **qa**: Production-like, reduced capacity, full testing
  - **prod**: High availability, multi-AZ, full monitoring

### Module System
- Custom modules in `modules/` directory
- Example module: `s3-bucket` - Production-ready S3 bucket module with:
  - Server-side encryption (AES256)
  - Versioning support
  - Public access blocking
  - Lifecycle rules
  - Comprehensive documentation
- Module structure: main.tf, variables.tf, outputs.tf, README.md
- All modules include validation and best practices

### Naming Conventions
- Resource prefix pattern: `{prefix}-{env}-{resource-type}-{name}`
- Defined in locals.tf using `local.resource_prefix`
- Consistent naming enforced via TFLint rules (snake_case)

## CI/CD Workflows

### Automated Quality Checks (Pull Requests)
1. **Pre-commit CI** (.github/workflows/pre-commit-ci.yaml): Runs terraform fmt, validate, tflint, checkov, gitleaks
2. **Terraform Docs** (.github/workflows/tf-docs.yaml): Auto-generates documentation in TF-DOCS.md
3. **Infracost** (.github/workflows/infracost.yaml): Adds cost estimates as PR comments
4. **Checkov** (.github/workflows/checkov.yaml): Standalone security scanning
5. **GitLeaks** (.github/workflows/gitleaks.yaml): Secret detection

### Deployment Workflow (terraform-aws.yml)
- Manual trigger via workflow_dispatch
- **Environment selection**: dev, qa, prod
- **Actions**: plan, apply, destroy
- Features:
  - Environment-specific tfvars loading
  - GitHub Environment protection rules support
  - Plan artifact upload for review
  - Terraform output capture and storage
  - Format and validation checks before plan
- Requires GitHub secrets: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION
- Best practice: Configure approval requirements for prod environment in Settings > Environments

### Release Management
- Semantic Release configured (.releaserc.json)
- Auto-generates CHANGELOG.md from conventional commits
- Triggered by release.yaml workflow
- Branches: main, master

## Branching & Development Workflow

**CRITICAL RULES:**
- NEVER commit directly to the `main` branch
- ALL features and fixes MUST be implemented in feature branches
- Feature branch naming: `feat/description`, `fix/description`, `chore/description`
- Create pull requests to merge into `main`
- All PR checks must pass before merging

**Workflow:**
1. Create feature branch from `main`: `git checkout -b feat/your-feature-name`
2. Implement changes with semantic commits
3. Push branch and create pull request
4. Wait for CI/CD checks to pass
5. Merge via pull request after approval

## Commit Convention

Follow Conventional Commits format (enforced by semantic-release):

- `feat:` - Minor version bump (new feature)
- `fix:` - Patch version bump (bug fix)
- `chore:` - No version bump (maintenance)
- `docs:` - Documentation changes
- `refactor:` - Code restructuring
- `test:` - Test additions/updates
- `BREAKING CHANGE:` in commit body - Major version bump

**Commit Message Format:**
```text
<type>(<scope>): <subject>

<body>
```

**Example:**
```text
feat(s3): add encryption configuration for buckets

Configure AES256 encryption for all S3 buckets to meet
security compliance requirements.
```

**DO NOT include AI attribution or co-author tags in commit messages.**

## Pre-commit Hooks

The following checks run automatically before each commit:

**File Quality:**
- trailing-whitespace, end-of-file-fixer, check-yaml
- check-added-large-files, check-merge-conflict
- detect-private-key

**Terraform Quality:**
- terraform_fmt: Auto-formats .tf files
- terraform_validate: Validates configuration syntax
- terraform_docs: Auto-generates documentation in README.md
- terraform_tflint: Linting with comprehensive rules (.tflint.hcl)

**Security Scanning:**
- terraform_checkov: Security and compliance scanning (.checkov.yml)
- gitleaks: Secret detection

All hooks include detailed descriptions and best practice configurations.

## Security & Compliance

### Checkov Configuration
- Framework: terraform, terraform_plan
- Configuration: .checkov.yml
- Quiet mode enabled
- Add skip-check entries in .checkov.yml to suppress specific findings

### TFLint Configuration
- **AWS Plugin enabled**: Version 0.38.0 for AWS-specific rules
- **Enabled rules**:
  - terraform_required_version, terraform_required_providers
  - terraform_typed_variables, terraform_documented_variables, terraform_documented_outputs
  - terraform_naming_convention (snake_case enforced)
  - terraform_deprecated_interpolation, terraform_unused_declarations
  - terraform_module_pinned_source (flexible style for git/semver)
  - terraform_standard_module_structure
- Run `tflint --init` first time to download AWS plugin
- Configuration optimized for production use while maintaining flexibility

## Development Container

DevContainer configuration available in `.devcontainer/`:
- Pre-configured with Terraform tools
- VSCode extensions recommendations in `.vscode/extensions.json`
- Docker-based environment for consistency

## Examples Directory

The `examples/` directory contains production-ready patterns:

1. **data-sources/**: AWS data source usage examples
   - VPC and subnet queries
   - AMI lookups (Amazon Linux, Ubuntu)
   - Account information retrieval

2. **module-composition/**: Module reuse and composition
   - Multiple instances of same module
   - Environment-specific configurations
   - Module output dependencies

3. **complete-infrastructure/**: Full stack example (template)
   - Multi-service integration patterns
   - Network architecture examples
   - Security best practices demonstration

Each example includes:
- Complete working configuration
- Detailed README.md
- Best practices documentation
- Usage instructions

## Important Notes

- **Terraform version**: Managed via .terraform-version (1.10.5) and versions.tf (>= 1.0)
- **Environment tfvars**: Always use environment-specific tfvars files for deployments
- **Security scanning**: Two layers - TFLint and Checkov
- **Secret detection**: Gitleaks will block commits containing secrets
- **Backend**: Defaults to local - update versions.tf for team collaboration
- **Auto-tagging**: All resources tagged via provider default_tags + mergeable in locals.tf
- **Infracost**: Requires INFRACOST_API_KEY secret for cost estimates
- **Pre-commit hooks**: May auto-fix and modify staged files (fmt, whitespace)
- **Module documentation**: Each module includes README.md with usage examples
- **Naming conventions**: snake_case enforced by TFLint for all resources
- **GitHub Environments**: Configure in Settings > Environments for prod approval workflows
