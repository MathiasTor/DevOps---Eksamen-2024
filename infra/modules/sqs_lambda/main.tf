resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda-sqs-s3-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:PutObject", "s3:GetObject"],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      },
      {
        Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"],
        Effect   = "Allow",
        Resource = aws_sqs_queue.image_queue.arn
      },
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_sqs_queue" "image_queue" {
  name = var.sqs_queue_name
}

resource "aws_lambda_function" "lambda" {
  filename         = "${path.module}/lambda_sqs.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_sqs.lambda_handler"
  runtime          = "python3.9"
  timeout          = 15

  environment {
    variables = {
      BUCKET_NAME = var.s3_bucket_name
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.image_queue.arn
  function_name    = aws_lambda_function.lambda.arn
  batch_size       = 10
}

resource "aws_sns_topic" "cloudwatch_alarm_topic" {
  name = "cloudwatch-alarm-topic"
}

resource "aws_sns_topic_subscription" "email_address_subscription" {
  topic_arn = aws_sns_topic.cloudwatch_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "aws_cloudwatch_metric_alarm" "sqs_queue_alarm" {
  alarm_name          = "ApproximateAgeOfOldestMessage-Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Maximum"
  threshold = 15
  alarm_description = "Triggers when oldest message in SQS queue is older than configured threshold"
  alarm_actions = [aws_sns_topic.cloudwatch_alarm_topic.arn]
  dimensions = {
    QueueName = aws_sqs_queue.image_queue.name
  }
}
