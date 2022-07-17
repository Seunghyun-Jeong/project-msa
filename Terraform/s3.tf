#sales-api
data "archive_file" "sales-api-file" {
  type = "zip"

  source_dir  = "${path.module}/sales-api-src"
  output_path = "${path.module}/sales-api.zip"
}

resource "aws_s3_bucket" "sales-api-bucket" {
  bucket = "sales-api-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "sales-api-acl" {
  bucket = aws_s3_bucket.sales-api-bucket.id
  acl    = "private"
}

resource "aws_s3_object" "sales-api-obj" {
  bucket = aws_s3_bucket.sales-api-bucket.id
  key    = "sales-api.zip"
  source = data.archive_file.sales-api-file.output_path
  etag = filemd5(data.archive_file.sales-api-file.output_path)
}

#stock_lambda
data "archive_file" "stock-lambda-file" {
  type = "zip"

  source_dir  = "${path.module}/stock-lambda-src"
  output_path = "${path.module}/stock-lambda.zip"
}

resource "aws_s3_bucket" "stock-lambda-bucket" {
  bucket = "stock-lambda-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "stock-lambda-acl" {
  bucket = aws_s3_bucket.stock-lambda-bucket.id
  acl    = "private"
}


resource "aws_s3_object" "stock-lambda-obj" {
  bucket = aws_s3_bucket.stock-lambda-bucket.id
  key    = "stock-lambda.zip"
  source = data.archive_file.stock-lambda-file.output_path
  etag = filemd5(data.archive_file.stock-lambda-file.output_path)
}

#stock-increase-lambda
data "archive_file" "stock-increase-file" {
  type = "zip"

  source_dir  = "${path.module}/stock-increase-src"
  output_path = "${path.module}/stock-increase.zip"
}

resource "aws_s3_bucket" "stock-increase-bucket" {
  bucket = "stock-increase-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "stock-increase-acl" {
  bucket = aws_s3_bucket.stock-increase-bucket.id
  acl    = "private"
}

resource "aws_s3_object" "stock-increase-obj" {
  bucket = aws_s3_bucket.stock-increase-bucket.id
  key    = "stock-increase.zip"
  source = data.archive_file.stock-increase-file.output_path
  etag = filemd5(data.archive_file.stock-increase-file.output_path)
}