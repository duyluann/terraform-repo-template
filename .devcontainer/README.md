# Development Container Configuration

> **🚀 Simplified Development Environment**
>
> This devcontainer provides a streamlined setup using standard DevContainer features:
> - ✅ **Fast builds** - Uses official base image and features
> - ✅ **Simple configuration** - No custom Dockerfile needed
> - ✅ **Standard tools** - Terraform, TFLint, AWS CLI, kubectl, Node.js
> - ✅ **Works everywhere** - Local VSCode and GitHub Codespaces
>
> **Key Features:**
> - Uses official Microsoft base image (ubuntu-22.04)
> - All tools installed via DevContainer features
> - Automatic credential mounting from host
> - Minimal setup script for additional tools

This directory contains the development container configuration for this Terraform project. The devcontainer provides a consistent, reproducible development environment with all necessary tools pre-installed.

## What's Included

### Core Tools (via DevContainer Features)
- **Terraform & TFLint**: Infrastructure as Code tool and linter
- **AWS CLI**: Amazon Web Services command-line interface
- **kubectl & Helm**: Kubernetes CLI tools
- **Node.js LTS**: JavaScript runtime and npm
- **GitHub CLI**: GitHub command-line tool
- **Git**: Version control
- **Python 3.11**: For pre-commit and checkov

### Additional Tools (installed via setup script)
- **Kustomize**: Kubernetes manifest customization tool
- **Pre-commit**: Git hook framework
- **Checkov**: Security and compliance scanner
- **Claude Code**: AI-powered code assistant (optional)

### VS Code Extensions
- **HashiCorp Terraform**: Official Terraform extension
- **Kubernetes Tools**: Kubernetes development support
- **GitLens**: Enhanced Git capabilities
- **YAML**: YAML language support
- **EditorConfig**: Consistent coding styles
- **GitHub Actions**: GitHub workflow support

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) or [Docker Engine](https://docs.docker.com/engine/install/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- At least 2GB RAM allocated to Docker
- At least 20GB disk space

## Quick Start

### 1. Open in Container

1. Open VS Code in this project directory
2. Press `F1` and select "Dev Containers: Reopen in Container"
3. Wait for the container to build (first time: ~3-5 minutes)

The setup script will automatically:
- Install pre-commit and checkov
- Configure git safe directory
- Install pre-commit hooks
- Initialize TFLint plugins
- Display tool versions

### 2. Verify Installation

Open a terminal in VS Code and run:

```bash
terraform version
tflint --version
pre-commit --version
checkov --version
aws --version
kubectl version --client
kustomize version
helm version
```

## Configuration

### Automatic Mounts

The devcontainer automatically mounts from your host machine:
- **Git Config**: `~/.gitconfig` for Git settings
- **SSH Keys**: `~/.ssh` for Git operations
- **AWS Credentials**: `~/.aws` for AWS authentication
- **Kubernetes Config**: `~/.kube` for kubectl access

### Environment Variables

AWS credentials are automatically available from:
- Host environment variables (local development)
- GitHub Codespaces secrets (cloud development)

Set these in your environment:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (defaults to ap-southeast-1)

### VS Code Settings

Pre-configured for Terraform development:
- Auto-formatting on save
- Terraform validation enabled
- 2-space indentation
- Trailing whitespace removal
- File associations for .tf, .tfvars, .hcl

## Working with the Container

### Running Terraform Commands

```bash
# Initialize Terraform
terraform init

# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Plan infrastructure
terraform plan -var-file=environments/dev/dev.tfvars

# Apply changes
terraform apply -var-file=environments/dev/dev.tfvars
```

### Running Pre-commit Hooks

```bash
# Run all hooks on all files
pre-commit run --all-files

# Run specific hook
pre-commit run terraform-fmt --all-files

# Update hooks to latest versions
pre-commit autoupdate
```

### Running Linting and Security Scans

```bash
# TFLint
tflint --config=.tflint.hcl

# Checkov
checkov --config-file=.checkov.yml
```

### Working with Kubernetes

```bash
# Configure kubectl for EKS cluster
aws eks update-kubeconfig --region ap-southeast-1 --name ops4life-dev-cluster

# Verify cluster access
kubectl get nodes

# Build Kustomize manifests
kustomize build k8s/apps/sample-nginx/overlays/dev/

# Apply manifests with Kustomize
kubectl apply -k k8s/apps/sample-nginx/overlays/dev/

# Watch deployment progress
kubectl rollout status deployment/nginx -n dev

# View logs
kubectl logs -n dev -l app=sample-nginx --tail=100 -f

# Working with Helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx
helm install my-release bitnami/nginx
```

### AWS Authentication

The container uses your mounted AWS credentials from `~/.aws`.

```bash
# Test AWS connection
aws sts get-caller-identity

# Use specific profile
export AWS_PROFILE=my-profile

# Use specific region
export AWS_REGION=us-west-2
```

## Customization

### Adding VS Code Extensions

Edit `.devcontainer/devcontainer.json` and add to the extensions array:

```json
"extensions": [
  "your.extension.id"
]
```

### Adding DevContainer Features

Add features to `.devcontainer/devcontainer.json`:

```json
"features": {
  "ghcr.io/devcontainers/features/feature-name:version": {}
}
```

Browse available features at https://containers.dev/features

### Adding Tools

Edit `.devcontainer/setup.sh` to add custom tools:

```bash
# Install additional Python packages
pip3 install --user your-package

# Install additional npm packages
npm install -g your-package
```

## Troubleshooting

### Container Won't Start

```bash
# Check Docker is running
docker ps

# Clean up old containers and images
docker system prune -a

# Rebuild container
# Press F1 → "Dev Containers: Rebuild Container"
```

### Pre-commit Hooks Failing

```bash
# Reinstall hooks
pre-commit clean
pre-commit install --install-hooks
```

### TFLint Plugins Not Found

```bash
# Initialize TFLint plugins
tflint --init --config=.tflint.hcl
```

### Permission Issues with Mounted Files

```bash
# Fix SSH key permissions
chmod 600 ~/.ssh/id_* 2>/dev/null

# Current user should be 'vscode'
whoami
```

## Best Practices

1. **Commit from Container**: Always commit from within the devcontainer to ensure hooks run
2. **Rebuild Regularly**: Rebuild container periodically to get latest tool versions
3. **Resource Allocation**: Ensure Docker has at least 2GB RAM allocated

## Additional Resources

- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev Container Features](https://containers.dev/features)
- [Terraform Documentation](https://www.terraform.io/docs)
- [Pre-commit Documentation](https://pre-commit.com/)

---

**Note**: This devcontainer is version controlled and provides a consistent development environment for the entire team.
