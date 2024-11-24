output "lambda_function_arn" {
  value = module.sqs_lambda.lambda_function_arn
}

output "sqs_queue_url" {
  value = module.sqs_lambda.sqs_queue_url
}
