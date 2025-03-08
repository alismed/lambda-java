terraform {
  backend "s3" {
    bucket         = "alismed-terraform"
    key            = "lambda-java/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}