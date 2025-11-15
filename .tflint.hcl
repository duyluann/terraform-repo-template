# TFLint Configuration
# Best practice: Enable rules that enforce standards and catch common mistakes

config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"

  call_module_type = "all"  # all, local, or none
  force = false
}

# AWS Plugin for AWS-specific rules
plugin "aws" {
  enabled = true
  version = "0.38.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Terraform Core Rules
# Enable important rules for best practices

rule "terraform_required_version" {
  enabled = true  # Enforce Terraform version constraint
}

rule "terraform_required_providers" {
  enabled = true  # Ensure all providers have version constraints
}

rule "terraform_typed_variables" {
  enabled = true  # Enforce variable type declarations
}

rule "terraform_documented_variables" {
  enabled = true  # Require variable descriptions
}

rule "terraform_documented_outputs" {
  enabled = true  # Require output descriptions
}

rule "terraform_naming_convention" {
  enabled = true  # Enforce naming conventions

  # Customize naming patterns (snake_case recommended)
  variable {
    format = "snake_case"
  }

  locals {
    format = "snake_case"
  }

  output {
    format = "snake_case"
  }

  resource {
    format = "snake_case"
  }

  module {
    format = "snake_case"
  }

  data {
    format = "snake_case"
  }
}

rule "terraform_deprecated_interpolation" {
  enabled = true  # Catch deprecated ${var.foo} in strings
}

rule "terraform_unused_declarations" {
  enabled = true  # Find unused variables and outputs
}

rule "terraform_comment_syntax" {
  enabled = true  # Enforce # for comments, not //
}

rule "terraform_deprecated_index" {
  enabled = true  # Catch deprecated index syntax
}

rule "terraform_module_pinned_source" {
  enabled = true  # Require module sources to be pinned
  style   = "flexible"  # Allow semver and git refs
}

rule "terraform_standard_module_structure" {
  enabled = true  # Enforce standard module structure
}

rule "terraform_workspace_remote" {
  enabled = false  # Disable if using local backend
}

# AWS-Specific Rules (enforced by AWS plugin)
# These catch common AWS resource misconfigurations

rule "aws_resource_missing_tags" {
  enabled = false  # Disabled - using provider default_tags
  tags = ["Name", "Environment"]
}

# Best practices:
# 1. Enable rules that enforce documentation and typing
# 2. Use naming conventions for consistency
# 3. Catch deprecated syntax early
# 4. Pin module versions for reproducibility
# 5. Customize rules based on team standards
