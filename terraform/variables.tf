variable "domain" {
  type = string
}

variable "mail-from" {
  type = string
  default = "no-reply"
}

variable "domain_arn" {
  type = string
  default = ""
}

variable "route53_zone_id" {
  type = string
  default = ""
}
