# Configure the AWS Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = var.env
    }
  }
}
