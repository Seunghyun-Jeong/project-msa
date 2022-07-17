module "sale-api-gw" {
  source = "terraform-aws-modules/apigateway-v2/aws"
  name   = "sales-api-gw"
  protocol_type = "HTTP"
  create_api_domain_name = false

  integrations = {
    "$default" = {
      lambda_arn = "${aws_lambda_function.sales-api.arn}"
      payload_format_version = "2.0"
    }
  }
}

resource "aws_lambda_permission" "sales-api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sales-api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.sale-api-gw.apigatewayv2_api_execution_arn}/*"
}

#stock_increase
module "increase-gw" {
  source = "terraform-aws-modules/apigateway-v2/aws"
  name   = "increase-gw"
  protocol_type = "HTTP"
  create_api_domain_name = false

  integrations = {
    "$default" = {
      lambda_arn = "${aws_lambda_function.stock-increase-lambda.arn}"
      payload_format_version = "2.0"
    }
  }
}

resource "aws_lambda_permission" "stock-increase-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stock-increase-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.increase-gw.apigatewayv2_api_execution_arn}/*"
}