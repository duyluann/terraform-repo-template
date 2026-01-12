#!/usr/bin/env bash
# Post-create setup script for devcontainer
set -e

echo "🚀 Setting up Terraform development environment..."

# Install Terraform
if ! command -v terraform &> /dev/null; then
  echo "📦 Installing Terraform..."
  TERRAFORM_VERSION="1.10.5"
  curl -sL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o /tmp/terraform.zip
  unzip -q /tmp/terraform.zip -d /tmp
  sudo mv /tmp/terraform /usr/local/bin/
  sudo chmod +x /usr/local/bin/terraform
  rm -f /tmp/terraform.zip
  echo "✅ Terraform ${TERRAFORM_VERSION} installed successfully"
fi

# Install TFLint
if ! command -v tflint &> /dev/null; then
  echo "📦 Installing TFLint..."
  TFLINT_VERSION="0.60.0"
  curl -sL "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" -o /tmp/tflint.zip
  unzip -q /tmp/tflint.zip -d /tmp
  sudo mv /tmp/tflint /usr/local/bin/
  sudo chmod +x /usr/local/bin/tflint
  rm -f /tmp/tflint.zip
  echo "✅ TFLint ${TFLINT_VERSION} installed successfully"
fi

# Install terraform-docs
if ! command -v terraform-docs &> /dev/null; then
  echo "📦 Installing terraform-docs..."
  TERRAFORM_DOCS_VERSION="0.19.0"
  curl -sL "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz" -o /tmp/terraform-docs.tar.gz
  tar -xzf /tmp/terraform-docs.tar.gz -C /tmp
  sudo mv /tmp/terraform-docs /usr/local/bin/
  sudo chmod +x /usr/local/bin/terraform-docs
  rm -f /tmp/terraform-docs.tar.gz
  echo "✅ terraform-docs ${TERRAFORM_DOCS_VERSION} installed successfully"
fi

# Install pre-commit
pip3 install --user pre-commit

# Install checkov for security scanning
pip3 install --user checkov

# Install gitleaks for secret detection
if ! command -v gitleaks &> /dev/null; then
  echo "📦 Installing gitleaks..."
  GITLEAKS_VERSION="8.30.0"
  curl -sL "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz" -o /tmp/gitleaks.tar.gz
  tar -xzf /tmp/gitleaks.tar.gz -C /tmp
  sudo mv /tmp/gitleaks /usr/local/bin/
  sudo chmod +x /usr/local/bin/gitleaks
  rm -f /tmp/gitleaks.tar.gz
  echo "✅ gitleaks ${GITLEAKS_VERSION} installed successfully"
fi

# Install Claude Code CLI (optional)
npm install -g @anthropic-ai/claude-code 2>/dev/null || echo "⚠️  Claude Code installation skipped"

# Configure git safe directory
git config --global --add safe.directory "${PWD}" 2>/dev/null || true

# Install pre-commit hooks if config exists
if [ -f ".pre-commit-config.yaml" ]; then
  echo "📦 Installing pre-commit hooks..."
  pre-commit install --install-hooks || echo "⚠️  Pre-commit hooks will be installed on first commit"
fi

# Initialize TFLint plugins if config exists
if [ -f ".tflint.hcl" ]; then
  echo "📦 Initializing TFLint plugins..."
  tflint --init --config=.tflint.hcl || echo "⚠️  TFLint will initialize on first use"
fi

# Install AWS CLI if not already installed
if ! command -v aws &> /dev/null; then
  echo "📦 Installing AWS CLI..."
  curl -sL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install
  rm -rf /tmp/awscliv2.zip /tmp/aws
  echo "✅ AWS CLI installed successfully"
fi

# Install Helm
if ! command -v helm &> /dev/null; then
  echo "📦 Installing Helm..."
  HELM_VERSION="3.17.0"
  curl -sL "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" -o /tmp/helm.tar.gz
  tar -xzf /tmp/helm.tar.gz -C /tmp
  sudo mv /tmp/linux-amd64/helm /usr/local/bin/
  sudo chmod +x /usr/local/bin/helm
  rm -rf /tmp/helm.tar.gz /tmp/linux-amd64
  echo "✅ Helm ${HELM_VERSION} installed successfully"
fi

# Install Kustomize
if ! command -v kustomize &> /dev/null; then
  echo "📦 Installing Kustomize..."
  KUSTOMIZE_VERSION="5.5.0"
  curl -sL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" -o /tmp/kustomize.tar.gz
  tar -xzf /tmp/kustomize.tar.gz -C /tmp
  sudo mv /tmp/kustomize /usr/local/bin/
  sudo chmod +x /usr/local/bin/kustomize
  rm -f /tmp/kustomize.tar.gz
  echo "✅ Kustomize ${KUSTOMIZE_VERSION} installed successfully"
fi

# Display tool versions
echo ""
echo "=== ✅ Installed Tools ==="
terraform version | head -n 1
tflint --version
echo "terraform-docs: $(terraform-docs --version 2>/dev/null | head -n 1)"
echo "Pre-commit: $(pre-commit --version)"
echo "Checkov: $(checkov --version 2>/dev/null | head -n 1)"
echo "Gitleaks: $(gitleaks version 2>/dev/null | head -n 1)"
aws --version
kubectl version --client --short 2>/dev/null | head -n 1 || echo "kubectl: $(kubectl version --client -o json 2>/dev/null | jq -r .clientVersion.gitVersion)"
helm version --short 2>/dev/null || echo "Helm: $(helm version --template='{{.Version}}' 2>/dev/null)"
kustomize version --short 2>/dev/null || echo "Kustomize: $(kustomize version 2>/dev/null | head -n 1)"
node --version
npm --version

echo ""
echo "✨ Setup complete! Ready to code."
