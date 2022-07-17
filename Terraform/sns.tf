resource "aws_sns_topic" "stock_empty" {
  name = "stock_empty"
}

resource "aws_sns_topic_subscription" "sqs_target" {
  topic_arn = aws_sns_topic.stock_empty.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.stock_queue.arn
}