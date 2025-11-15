provider "aws" {
  region  = "us-east-2"
  profile = "localplay"
}

terraform {
  backend "s3" {
    bucket  = "bun-lambda-terraform"
    key     = "terraform-state.tfstate"
    region  = "us-east-2"
    profile = "localplay"
  }
}
