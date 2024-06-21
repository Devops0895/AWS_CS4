terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "Administrator"
}

resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}
