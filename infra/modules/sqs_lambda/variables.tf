variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket for storing generated images"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

