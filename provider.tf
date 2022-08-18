# Defining provider
provider "aws" {
  region  = var.aws_region
  profile = "tf-user"
  version = "~> 3.12"
}