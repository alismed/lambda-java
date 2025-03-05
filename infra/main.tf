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

resource "aws_iam_role" "lambda_role" {
  name               = "GetTime_Lambda_Role"
  assume_role_policy = file("trust/GetTime_Lambda_role.json")
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "GetTime_Lambda_iam_policy"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = file("trust/GetTime_Lambda_policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "../app/src/"
  output_path = "../app/target/app.zip"
}

resource "aws_lambda_function" "get_time" {
  filename      = "../app/target/app.zip"
  function_name = "GetTime"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}