#!/usr/bin/env bash
set -e

# Display welcome message
clear
printf "\e[0;32mTerraform Multi-Cloud Development Environment: $(basename $PWD)\e[0m\n\n"

# Display installed tools and versions
echo "=== Installed Tools ==="
echo "Terraform: $(terraform version | head -n 1)"
echo "AWS CLI: $(aws --version 2>&1)"
echo "Azure CLI: $(az version --output tsv 2>&1 | head -n 1 || echo 'Not available')"
echo "Google Cloud SDK: $(gcloud --version 2>&1 | head -n 1 || echo 'Not available')"
echo "TFLint: $(tflint --version)"
echo "Checkov: $(checkov --version 2>&1 || echo 'Not installed')"
echo "Pre-commit: $(pre-commit --version)"
echo "Claude Code: $(claude-code --version 2>&1 || echo 'Installing...')"
echo ""

# Display environment information
echo "=== Environment Information ==="
echo "Working Directory: $(pwd)"
echo "User: $(whoami)"
echo ""

# Display authentication status
echo "=== Authentication Status ==="
echo "AWS: Run '.devcontainer/scripts/aws-auth.sh' to authenticate"
echo "  Options: --profile PROFILE --region REGION --sso"
echo "Azure: Run '.devcontainer/scripts/azure-auth.sh' to authenticate"
echo "  Options: --subscription ID --tenant ID --service-principal"
echo "GCP: Run '.devcontainer/scripts/gcp-auth.sh' to authenticate"
echo "  Options: --project PROJECT_ID --credentials FILE"
echo ""

# Display helpful commands
echo "=== Helpful Commands ==="
echo "terraform init          - Initialize Terraform working directory"
echo "terraform plan          - Generate and show execution plan"
echo "terraform apply         - Build or change infrastructure"
echo "terraform validate      - Validate Terraform configuration"
echo "terraform fmt           - Format Terraform files"
echo "pre-commit run --all-files - Run pre-commit hooks on all files"
echo "tflint --init           - Initialize TFLint plugins"
echo ""

# Display project-specific information
if [ -f "README.md" ]; then
    echo "=== Project README Available ==="
    echo "Run 'cat README.md' or open README.md in the editor"
    echo ""
fi

# Configure git safe directory
git config --global --add safe.directory ${containerWorkspaceFolder} 2>/dev/null || true

# Install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f ".pre-commit-config.yaml" ]; then
    echo "Installing pre-commit hooks..."
    pre-commit install --install-hooks 2>/dev/null || echo "Pre-commit: Will install on first commit"
fi

# Initialize TFLint if .tflint.hcl exists
if [ -f ".tflint.hcl" ]; then
    echo "Initializing TFLint plugins..."
    tflint --init --config=.tflint.hcl 2>/dev/null || echo "TFLint: Will initialize on first use"
fi

echo ""
echo "Environment ready! Happy coding!"
echo ""
