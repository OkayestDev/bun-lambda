# Bun Lambda Terraform Module

A Terraform module to deploy AWS Lambda functions built with [Bun](https://bun.sh/). This module allows you to leverage Bun's fast JavaScript/TypeScript runtime in serverless workloads, making your Lambda deployments efficient and easy to manage.

## Features

- **Build & package Lambda using Bun**
- **Customizable Docker image name and tag**
- **Configurable Lambda handler path**
- **Specify execution role, memory size, and more**
- **Ready for TypeScript and JavaScript codebases**

---

## Usage

```hcl
module "bun_lambda" {
  source                    = "git::https://github.com/OkayestDev/bun-lambda?ref=master"
  image_name                = "my-bun-lambda"
  image_tag                 = "v1.0.0"
  lambda_function_handler   = "src/handler.ts"
  lambda_execution_role_arn = "arn:aws:iam::123456789012:role/lambda-execution-role"
  lambda_memory_size        = 512
  lambda_timeout            = 10
  code_path                 = "path-to-code-directory"
  package_lock_path         = "path-to-package.json"
  bun_lock_path             = "path-to-bun.lock"
}
```

See an [example](./example) of a basic api gw -> lambda implementation using this module

---

## Input Variables

| Variable                    | Description                                    | Type     | Default            |
| --------------------------- | ---------------------------------------------- | -------- | ------------------ |
| `package_json_path`         | path to package.json file                      | string   |                    |
| `bun_lock_path`             | path to bun.lock file                          | string   |                    |
| `code_path`                 | path to code directory                         | string   |                    |
| `aws_profile`               | optional aws-profile used during aws-cli calls | string   |                    |
| `image_name`                | Name of the Docker image to build              | string   | `"bun-lambda"`     |
| `image_tag`                 | Tag for the Docker image                       | string   | `"latest"`         |
| `lambda_function_handler`   | Path to lambda function handler                | string   | `"src/handler.ts"` |
| `lambda_execution_role_arn` | ARN of the lambda execution role               | string   | `null`             |
| `lambda_memory_size`        | Memory size of the lambda function             | number   | `1024`             |
| `lambda_timeout`            | Lambda function timeout (seconds)              | number   | `30`               |
| `lambda_name`               | Lambda function name                           | string   | `bun-lambda`       |
| `lambda_architectures`      | array of architectures for lambda              | string[] | `[x86_64]`         |
| `aws_region`                | region to resources are deployed to            | string   | `us-east-2`        |

---

## Requirements

- [Terraform](https://www.terraform.io/)
- [Docker](https://www.docker.com/products/docker-desktop/)
- [aws-cli](https://aws.amazon.com/cli/)
- [Bun](https://bun.sh/)

---

## Example Handler (TypeScript)

This module uses the lambda adapter. If running a server (Express, Fastify, etc). The server needs to be running on port 8080

```ts
import { createServer, get } from "valita-server";
import type { Request, Response } from "valita-server";

get("/", (_: Request): Response => {
  return {
    status: 200,
    body: { message: "Hello World" },
  };
});

const server = createServer({
  enableRequestLogging: true,
  enableResponseLogging: true,
});

// Docker Lambda adapter expects server to listen on port 8080
server.listen(8080, () => {
  console.log("Server is running on port 8080");
});
```

## Outputs

| Output Name                  | Description                                         |
| ---------------------------- | --------------------------------------------------- |
| `lambda_function_arn`        | ARN of the created Lambda function                  |
| `lambda_function_name`       | Name of the created Lambda function                 |
| `lambda_function_invoke_arn` | ARN used for invoking the Lambda function           |
| `lambda_function_role_arn`   | ARN of the IAM role assigned to the Lambda function |
| `ecr_repository_url`         | URL of the created ECR repository for Docker images |

## License

MIT @OkayestDev
