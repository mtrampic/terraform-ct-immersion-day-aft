provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    key = "terraform-ct-immersion-day-aft/terraform.tfstate"
  }
}


module "aft_pipeline" {
  source = "github.com/aws-ia/terraform-aws-control_tower_account_factory"
  # Required Variables
  ct_management_account_id    = var.ct_management_account_id
  log_archive_account_id      = var.log_archive_account_id
  audit_account_id            = var.audit_account_id
  aft_management_account_id   = var.aft_management_account_id
  ct_home_region              = var.aws_region
  tf_backend_secondary_region = var.aws_region_secondary

  # Terraform variables
  terraform_version      = "0.15.5"
  terraform_distribution = "oss"

  # VCS variables
  vcs_provider                                  = "github"
  account_request_repo_name                     = "${var.github_username}/account_request_repo"
  global_customizations_repo_name               = "${var.github_username}/global_customizations_repo"
  account_customizations_repo_name              = "${var.github_username}/account_customizations_repo"
  account_provisioning_customizations_repo_name = "${var.github_username}/account_provisioning_customizations_repo"

  # AFT Feature flags
  aft_feature_cloudtrail_data_events      = false
  aft_feature_enterprise_support          = false
  aft_feature_delete_default_vpcs_enabled = true
}

