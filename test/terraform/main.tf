provider "random" {}

provider "aws" {
  version = ">= 2.52.0"
  region  = "us-west-2"
}

provider "aws" {
  alias   = "for-certs"
  version = ">= 2.52.0"
  region  = "us-east-1"  
}

module "auth" {
  source = "../../terraform"

  providers = {
    aws = aws
    aws.use1 = aws.for-certs
  }

  domain = "speaker"
  auth_cert_domain = "*.speaker"
  route53_zone_id = "ZP6JGA5833WH6"
}

output "secret_id" {
  value = module.auth.secret_id
}