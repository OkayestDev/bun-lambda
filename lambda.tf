locals {
  lambdaImage = "${aws_ecr_repository.ecr.repository_url}@${data.aws_ecr_image.lambda_image.image_digest}"
}

data "aws_ecr_image" "lambda_image" {
  depends_on = [
    aws_ecr_repository.ecr,
    null_resource.docker_push
  ]
  repository_name = aws_ecr_repository.ecr.name
  image_tag       = var.image_tag
}

resource "aws_lambda_function" "bun_lambda" {
  depends_on = [
    aws_ecr_repository.ecr,
    null_resource.docker_push
  ]
  function_name = var.lambda_name
  architectures = var.lambda_architectures
  package_type  = "Image"
  image_uri     = local.lambdaImage
  memory_size   = var.lambda_memory_size
  role          = var.lambda_execution_role_arn != null ? var.lambda_execution_role_arn : aws_iam_role.lambda-role.arn
  timeout       = var.lambda_timeout
  image_config {
    command = ["bun", "run", var.lambda_function_handler]
  }
}
