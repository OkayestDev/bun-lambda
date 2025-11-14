provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "bun-lambda-terraform"
    key    = "terraform-state.tfstate"
    region = "us-east-2"
  }
}
