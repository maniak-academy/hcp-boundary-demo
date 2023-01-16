
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.50.0"
    }
    boundary = {
      source = "hashicorp/boundary"
      version = "1.1.3"
    }
  }
}

provider "aws" {
  region = local.region
}