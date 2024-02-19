provider "aws" {
  region = "eu-west-3"
  default_tags {
    tags = {
      Account     = "${var.account}"
      Owner       = "${var.owner}"
      Provisioned = "Terragrunt"
    }
  }
}