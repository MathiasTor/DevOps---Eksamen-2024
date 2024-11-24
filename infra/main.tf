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

  sqs_queue_name       = "image-generator-queue"
  s3_bucket_name       = "pgr301-couch-explorers"
  lambda_function_name = "image-generator-lambda-62"
}

