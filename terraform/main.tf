provider aws {
  region = var.region

  default_tags {
    tags = {
      Name        = local.name
      Environment = local.env
    }
  }
}

terraform {
  backend "s3" {
    bucket = "djangorless-infra"
    key    = "state.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}
