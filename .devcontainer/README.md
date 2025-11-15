# Development Container Configuration

This directory contains the development container configuration for this Terraform project. The devcontainer provides a consistent, reproducible development environment with all necessary tools pre-installed.

## What's Included

### Core Tools
- **Terraform**: Infrastructure as Code tool
- **TFLint**: Terraform linter with AWS plugin
- **TFSec**: Security scanning for Terraform (if available in base image)
- **Checkov**: Policy-as-code security scanner (if available in base image)
- **Pre-commit**: Git hook framework
- **GitHub CLI**: GitHub command-line tool
- **AWS CLI**: Amazon Web Services command-line interface

### Development Features
- **Oh My Zsh**: Enhanced shell experience
- **Git**: Version control with GPG signing support
- **SSH**: Secure shell access with host key sharing
- **EditorConfig**: Consistent coding styles

### VS Code Extensions

**Terraform**:
- HashiCorp Terraform - Official Terraform extension
- 4ops Terraform - Additional Terraform tooling

**AWS**:
- AWS Toolkit - AWS resource management

**Git & Version Control**:
- GitLens - Enhanced Git capabilities
- Git Graph - Git history visualization

**Documentation**:
- Markdown All in One - Markdown authoring
- Markdown Lint - Markdown best practices

**Code Quality**:
- EditorConfig - Maintain consistent coding styles
- Prettier - Code formatter
- Code Spell Checker - Spelling verification

**Utilities**:
- Error Lens - Inline error highlighting
- TODO Tree - TODO/FIXME tracking
- Better Comments - Enhanced comment styling
- Indent Rainbow - Indentation visualization

## Prerequisites

### Required
- [Docker Desktop](https://www.docker.com/products/docker-desktop) or [Docker Engine](https://docs.docker.com/engine/install/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Recommended
- At least 4GB RAM allocated to Docker
- At least 32GB disk space for containers and cache

## Quick Start

### 1. Open in Container

**Method 1: Command Palette**
1. Open VS Code
2. Press `F1` or `Ctrl+Shift+P` (Windows/Linux) / `Cmd+Shift+P` (Mac)
3. Type "Dev Containers: Reopen in Container"
4. Wait for container to build and start

**Method 2: Notification**
1. Open the project in VS Code
2. Click "Reopen in Container" when prompted

**Method 3: Remote Explorer**
1. Click the Remote Explorer icon in the sidebar
2. Right-click the project folder
3. Select "Open Folder in Container"

### 2. First-Time Setup

When the container starts for the first time:
1. Dependencies will be verified
2. Pre-commit hooks will be installed
3. TFLint AWS plugin will be downloaded
4. Tool versions will be displayed

This process takes 1-3 minutes on first run.

### 3. Verify Installation

Open a terminal in VS Code and run:

```bash
# Check Terraform version
terraform version

# Check TFLint
tflint --version

# Check pre-commit
pre-commit --version

# Check AWS CLI (if needed)
aws --version

# Check GitHub CLI (if needed)
gh --version
```

## Configuration

### Mounts

The devcontainer automatically mounts:
- **Workspace**: Your project directory to `/app`
- **SSH Keys**: `~/.ssh` (read-only) for Git operations
- **GPG Keys**: `~/.gnupg` (read-only) for commit signing
- **AWS Config**: `~/.aws` (read-only) for AWS operations
- **Git Config**: `~/.gitconfig` (read-only) for Git settings

### Environment Variables

Pre-configured environment variables:
- `TF_PLUGIN_CACHE_DIR`: Terraform plugin cache location
- `TF_CLI_CONFIG_FILE`: Terraform CLI configuration
- `EDITOR`: Default editor for Git and other tools
- `VISUAL`: Visual editor preference

### VS Code Settings

Configured for Terraform development:
- Auto-formatting on save
- Terraform validation on save
- 2-space indentation
- Trailing whitespace removal
- Final newline insertion
- Code rulers at 80 and 120 characters

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

# TFSec (if installed)
tfsec --config-file=.tfsec.yml

# Checkov (if installed)
checkov --config-file=.checkov.yml
```

### AWS Configuration

If you need to use AWS services:

```bash
# Configure AWS CLI (credentials will be read from mounted ~/.aws)
aws configure list

# Test AWS connection
aws sts get-caller-identity
```

## Customization

### Adding Extensions

Edit `.devcontainer/devcontainer.json`:

```json
"extensions": [
  "your.extension.id"
]
```

### Adding Features

Add devcontainer features:

```json
"features": {
  "ghcr.io/devcontainers/features/feature-name:version": {}
}
```

Browse available features: https://containers.dev/features

### Changing Base Image

To use a different base image, update:

```json
"image": "your-custom-image:tag"
```

Or build from a Dockerfile:

```json
"build": {
  "dockerfile": "Dockerfile"
}
```

## Troubleshooting

### Container Won't Start

1. Check Docker is running: `docker ps`
2. Check disk space: `docker system df`
3. Clean up: `docker system prune -a`
4. Rebuild container: `Dev Containers: Rebuild Container`

### Pre-commit Hooks Failing

```bash
# Reinstall hooks
pre-commit clean
pre-commit install --install-hooks

# Update hooks
pre-commit autoupdate
```

### TFLint AWS Plugin Not Found

```bash
# Manually initialize TFLint
tflint --init --config=.tflint.hcl
```

### Permission Issues

```bash
# Check current user
whoami  # Should be tf-user

# Fix permissions if needed
sudo chown -R tf-user:tf-user /app
```

### Git Operations Failing

```bash
# Verify Git configuration
git config --list

# Set safe directory if needed
git config --global --add safe.directory /app
```

## Performance Optimization

### Terraform Plugin Cache

The container uses a persistent plugin cache to speed up `terraform init`:

```bash
# Location
echo $TF_PLUGIN_CACHE_DIR

# Clear cache if needed
rm -rf ~/.terraform.d/plugin-cache/*
```

### Docker Performance

**macOS**:
- Use VirtioFS for file sharing (Docker Desktop settings)
- Allocate sufficient resources (4GB+ RAM, 4+ CPUs)

**Windows**:
- Use WSL 2 backend (Docker Desktop settings)
- Store project files in WSL filesystem, not Windows

**Linux**:
- Native performance, no special configuration needed

## Best Practices

1. **Commit from Container**: Always commit code from within the devcontainer to ensure hooks run
2. **Don't Modify Mounts**: Avoid changing mounted directories (SSH, GPG keys)
3. **Use Version Control**: Commit devcontainer changes to share with team
4. **Keep Updated**: Regularly rebuild container to get latest tools
5. **Resource Limits**: Ensure Docker has enough resources allocated

## Additional Resources

- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev Container Specification](https://containers.dev/)
- [Terraform Documentation](https://www.terraform.io/docs)
- [Pre-commit Documentation](https://pre-commit.com/)

## Support

For issues with:
- **Devcontainer**: Check VS Code Dev Containers documentation
- **Terraform**: Check Terraform documentation or project CLAUDE.md
- **Pre-commit**: Check `.pre-commit-config.yaml` and pre-commit docs
- **Project-specific**: See README.md and CLAUDE.md in repository root

---

**Note**: The devcontainer configuration is version controlled and shared across the team to ensure consistent development environments.
