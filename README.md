# 🚧 Terraform Project Template

This repository provides a structured template for Terraform projects, enabling consistent and scalable infrastructure deployments. The template is equipped with best practices, CI/CD integration, and environment-specific configurations to streamline your infrastructure management.

## 📁 Repository Structure

```bash
.
├── .devcontainer
│   ├── Dockerfile                  # 🛠️ Defines the development environment for the project
│   └── devcontainer.json           # 🖥️ Configuration for VSCode Dev Containers
├── .editorconfig                   # 📝 Editor configuration file to maintain consistent coding styles
├── .github
│   ├── ISSUE_TEMPLATE
│   │   └── issue_template.md       # 🗒️ Template for GitHub issues
│   ├── dependabot.yml              # 🤖 Configuration for Dependabot to manage dependencies
│   ├── pull_request_template.md    # 📝 Template for pull requests
│   └── workflows
│       ├── stale.yaml              # 🕰️ Workflow to mark stale issues and PRs
│       └── terraform-aws.yml       # 🚀 CI/CD pipeline for Terraform using GitHub Actions
├── .gitignore                      # 🚫 Specifies files to be ignored by Git
├── .pre-commit-config.yaml         # ✅ Configuration for pre-commit hooks to enforce code quality
├── .terraform.lock.hcl             # 🔒 Lock file to ensure consistent Terraform provider versions
├── .vscode
│   └── extensions.json             # 💻 Recommended VSCode extensions for the project
├── CODEOWNERS                      # 👥 Defines code owners for the repository
├── LICENSE                         # 📜 License for the repository
├── README.md                       # 📖 This file
├── backend.tf                      # 🗄️ Configuration for Terraform backend
├── environments                    # 🌐 Environment-specific variable files
│   ├── dev
│   │   └── dev.tfvars              # 🛠️ Development environment variables
│   ├── prod
│   │   └── prod.tfvars             # 🚀 Production environment variables
│   └── qa
│       └── qa.tfvars               # 🧪 QA environment variables
├── locals.tf                       # 📍 Local values for the Terraform configuration
├── main.tf                         # 🔧 Main Terraform configuration file
├── modules                         # 📦 Directory for reusable Terraform modules
│   └── module1
│       ├── main.tf                 # 🔧 Module-specific configuration
│       ├── outputs.tf              # 📤 Module-specific outputs
│       └── variables.tf            # 📥 Module-specific variables
├── providers.tf                    # 🌐 Provider configurations
└── variables.tf                    # 📥 Input variables for the Terraform configuration
```

## 🚀 Getting Started

### 🧰 Prerequisites

- Terraform: Ensure you have Terraform installed.
- Docker: Required for the development container setup.
- VSCode: Recommended for development, with the Dev Containers extension.

### 🖥️ Development Environment

To get started with development, you can use the pre-configured development container:

1. Open in VSCode:

- Install the Dev Containers extension.
- Open the repository in VSCode.
- You should see a prompt to reopen the project in the dev container.

2. Build and Run:

- The dev container is pre-configured with all the necessary tools and extensions.
- You can start writing and testing your Terraform configurations immediately.

### 🛠️ Terraform Configuration

- Backend Configuration: The `backend.tf` file configures the remote state storage for Terraform.
- Environment Variables: The `environments/` directory contains environment-specific variable files (`.tfvars`).
- Modules: Reusable Terraform modules are stored in the `modules/` directory.

### 🔄 CI/CD

This repository includes a GitHub Actions workflow to automatically validate and apply your Terraform configurations:

- Terraform Validation: Automatically runs terraform validate on pull requests.
- Stale Issues: Automatically marks issues and pull requests as stale after a period of inactivity.

### ✅ Pre-Commit Hooks

Pre-commit hooks are set up to ensure code quality and consistency. To install the pre-commit hooks:

```bash
pre-commit install
```

## 🤝 Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed description of the changes.

## 📜 License

This project is licensed under the [MIT License](LICENSE).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
