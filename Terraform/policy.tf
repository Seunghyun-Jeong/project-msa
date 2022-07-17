data "aws_iam_policy_document" "pol-document" {
  statement {
    sid       = ""
    actions   = [
                "autoscaling:Describe*",
                "cloudwatch:*",
                "logs:*",
                "sns:*",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole"
    ]
    resources = [
      aws_sns_topic.stock_empty.arn
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "policy"
  policy = data.aws_iam_policy_document.pol-document.json
}

resource "aws_iam_role_policy_attachment" "POLICY_ATTACHMENT" {
  role       = aws_iam_role.sales-api-role.name
  policy_arn = aws_iam_policy.policy.arn
}


resource "aws_iam_role" "sales-api-role" {
  name               = "sales-api-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "lambda.amazonaws.com"
    },
    "Effect": "Allow"
  }
}
POLICY
}

resource "aws_iam_role_policy_attachment" "role-lambda" {
  role       = aws_iam_role.sales-api-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "role-sns" {
  role       = aws_iam_role.sales-api-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_role_policy_attachment" "role-sqs" {
  role       = aws_iam_role.sales-api-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}