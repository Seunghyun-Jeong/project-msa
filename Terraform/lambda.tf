#sales_api
resource "aws_lambda_function" "sales-api" {
  function_name = "sales-api"
  runtime = "nodejs14.x"
  handler = "handler.handler"
  # filename = data.archive_file.sales-api-file.output_path

  s3_bucket = aws_s3_bucket.sales-api-bucket.id
  s3_key = aws_s3_object.sales-api-obj.key

  source_code_hash = data.archive_file.sales-api-file.output_base64sha256

  role = aws_iam_role.sales-api-role.arn

  environment {
    variables = {
        HOSTNAME = "poject3-db.cpajpop7ewnt.ap-northeast-2.rds.amazonaws.com",
        USERNAME = "Seunghyun-Jeong",
        PASSWORD = "Seunghyun-Jeong",
        DATABASE = "Seunghyun-Jeong-DB",
        TOPIC_ARN = "${aws_sns_topic.stock_empty.arn}"
    }
  }
}

#stock_lambda
resource "aws_lambda_function" "stock-lambda" {
  function_name = "stock-lambda"
  runtime = "nodejs14.x"
  handler = "handler.handler"

  s3_bucket = aws_s3_bucket.stock-lambda-bucket.id
  s3_key = aws_s3_object.stock-lambda-obj.key

  source_code_hash = data.archive_file.stock-lambda-file.output_base64sha256

  role = aws_iam_role.sales-api-role.arn

  environment {
    variables = {
      CALLBACK_URL = "${module.increase-gw.apigatewayv2_api_api_endpoint}/product/donut"
    }
  }
}

#stock_increase_lambda
resource "aws_lambda_function" "stock-increase-lambda" {
  function_name = "stock-increase-lambda"
  runtime = "nodejs14.x"
  handler = "handler.handler"

  s3_bucket = aws_s3_bucket.stock-increase-bucket.id
  s3_key = aws_s3_object.stock-increase-obj.key

  source_code_hash = data.archive_file.stock-increase-file.output_base64sha256

  role = aws_iam_role.sales-api-role.arn

  environment {
    variables = {
        HOSTNAME = "poject3-db.cpajpop7ewnt.ap-northeast-2.rds.amazonaws.com",
        USERNAME = "Seunghyun-Jeong",
        PASSWORD = "Seunghyun-Jeong",
        DATABASE = "Seunghyun-Jeong-DB"
    }
  }
}