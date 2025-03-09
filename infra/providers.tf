terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.7.0"
    }
  }
}

provider "aws" {
  region  = var.region
  # If terraform.workspace is "default" (GitHub Actions), profile is set to null (not used)
  dynamic "default_tags" {
    for_each = terraform.workspace == "default" ? [] : [1]
    content {
      tags = {
        Environment = "local"
      }
    }
  }
  # If terraform.workspace is not "default" (local), uses the profile from var.profile (lstk)
  profile = terraform.workspace == "default" ? null : var.profile
}