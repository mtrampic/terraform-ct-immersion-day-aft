variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
}

variable "aws_region_secondary" {
  description = "The AWS region to deploy to."
  default     = "eu-west-1"
  type        = string
}

variable "ct_management_account_id" {
  type = string
}


variable "log_archive_account_id" {
  type = string
}


variable "audit_account_id" {
  type = string
}


variable "aft_management_account_id" {
  type = string
}


variable "github_username" {
  type = string
}