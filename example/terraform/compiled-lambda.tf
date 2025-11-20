module "compiled-lambda" {
  source                    = "../../"
  lambda_function_handler   = "compiled-handler.ts"
  image_name                = "compiled-lambda"
  image_tag                 = "latest"
  lambda_name               = "compiled-lambda"
  lambda_architectures      = ["x86_64"]
  lambda_memory_size        = 1024
  lambda_timeout            = 30
  lambda_execution_role_arn = null
  code_path                 = "${path.module}/../src/"
  package_json_path         = "${path.module}/../package.json"
  bun_lock_path             = "${path.module}/../bun.lock"
  aws_profile               = "localplay"
  compile_code              = true
}
