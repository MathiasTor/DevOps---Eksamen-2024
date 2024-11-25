terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
  backend "s3" {
    bucket         = "pgr301-2024-terraform-state"
    key            = "62/terraform.tfstate"
    region         = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "sqs_lambda" {
  source = "./modules/sqs_lambda"

  sqs_queue_name       = var.sqs_queue_name
  s3_bucket_name       = var.s3_bucket_name
  lambda_function_name = var.lambda_function_name
  alarm_email          = var.email_address
}

