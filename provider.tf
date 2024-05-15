terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "longji-state-bucket"
    key = "terraform/state"
    region = "eu-west-1"
  }
}