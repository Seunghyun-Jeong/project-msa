resource "aws_sqs_queue" "stock_queue" {
  name           = "stock_queue"
  redrive_policy = jsonencode(
            {
                deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
                maxReceiveCount     = 3
            }
  )
}  

resource "aws_sqs_queue" "dead_letter_queue" {
  name = "dead_letter_queue"

  tags = {
    Type = "dlq"
  }
}