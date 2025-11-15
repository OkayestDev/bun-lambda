variable "image_name" {
  description = "Name of the Docker image to build"
  type        = string
  default     = "bun-lambda"
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
  default     = "latest"
}

variable "lambda_function_handler" {
  description = "Path to lambda function handler"
  type        = string
  default     = "src/handler.ts"
}

variable "lambda_execution_role_arn" {
  description = "ARN of the lambda execution role"
  type        = string
  default     = null
}

variable "lambda_memory_size" {
  description = "Memory size of the lambda function"
  type        = number
  default     = 1024
}

variable "lambda_timeout" {
  description = "Timeout of the lambda function"
  type        = number
  default     = 30
}

variable "lambda_name" {
  description = "Name of the lambda function"
  type        = string
  default     = "bun-lambda"
}

variable "lambda_architectures" {
  description = "Architectures of the lambda function"
  type        = list(string)
  default     = ["x86_64"]
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "code_path" {
  description = "Path to the code directory. This is copied into lambda image."
  type        = string
}

variable "package_json_path" {
  description = "Path to the package.json file. This is copied into lambda image."
  type        = string
}

variable "bun_lock_path" {
  description = "Path to the bun.lock file. This is copied into lambda image."
  type        = string
}

variable "aws_profile" {
  description = "AWS profile to use from command line"
  type        = string
  default     = null
}
