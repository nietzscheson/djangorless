# core

data "aws_caller_identity" "current" {}

locals {
  env  = terraform.workspace
  # name = local.env == "prod" ? "djangorless" : "djangorless-${local.env}"
  name = "djangorless-${local.env}"
  account_id          = data.aws_caller_identity.current.account_id

}

variable "region" {
  type = string
  default = "us-east-1"
}
