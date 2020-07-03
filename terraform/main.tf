terraform {
  required_providers {
    aws = ">= 2.52.0"
    random = "~> 2.2.1"
  }
}

provider "aws" {
  alias = "use1"
}

resource "random_string" "identifier" {
  length = 6
  special = false
  upper = false
}