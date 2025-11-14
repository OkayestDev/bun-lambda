locals {
  lambdaImage = "${aws_ecr_repository.bun-lambda-ecr.repository_url}:latest"
}

resource "aws_lambda_function" "bun_lambda" {
  depends_on = [
    aws_ecr_repository.bun-lambda-ecr
  ]
  description   = ""
  function_name = "bun_lambda"
  architectures = [
    "x86_64"
  ]
  package_type = "Image"
  image_config {
    command = ["/var/task/target/debug/bun_lambda"]
  }
  image_uri   = local.lambdaImage
  memory_size = 1024
  role        = aws_iam_role.lambda-role.arn
  timeout     = 30
}
