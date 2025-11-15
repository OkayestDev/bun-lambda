output "lambda_function_arn" {
  value = aws_lambda_function.bun_lambda.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.bun_lambda.function_name
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.bun_lambda.invoke_arn
}

output "lambda_function_role_arn" {
  value = aws_lambda_function.bun_lambda.role
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}
