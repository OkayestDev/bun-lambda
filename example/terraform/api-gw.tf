resource "aws_apigatewayv2_api" "lambda_api" {
  name          = "lambda-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "compiled_lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = module.compiled-lambda.lambda_function_invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "transpiled_lambda_integration" {
  api_id           = aws_apigatewayv2_api.lambda_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = module.transpiled-lambda.lambda_function_invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "compiled_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "ANY /compiled"
  target    = "integrations/${aws_apigatewayv2_integration.compiled_lambda_integration.id}"
}

resource "aws_apigatewayv2_route" "transpiled_route" {
  api_id    = aws_apigatewayv2_api.lambda_api.id
  route_key = "ANY /transpiled"
  target    = "integrations/${aws_apigatewayv2_integration.transpiled_lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.lambda_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw_compiled" {
  statement_id  = "AllowAPIGatewayInvokeCompiled"
  action        = "lambda:InvokeFunction"
  function_name = module.compiled-lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "apigw_transpiled" {
  statement_id  = "AllowAPIGatewayInvokeTranspiled"
  action        = "lambda:InvokeFunction"
  function_name = module.transpiled-lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}

output "api_gw_url" {
  value = aws_apigatewayv2_api.lambda_api.api_endpoint
}
