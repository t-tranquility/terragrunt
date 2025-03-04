locals {
  # Specify organization variables
  organization_name = {
    name: "",
  }

  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.account_id
  region   = local.region_vars.locals.region

  profile_name = "${local.organization.name}-${local.account_name}"
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "${local.region}"

      profile = "${local.profile_name}"

      allowed_account_ids = ["${local.account_id}"]

      default_tags {
        tags = {
          Env       = "${local.account_name}",
          ManagedBy = "Terragrunt"
        }
      }
    }
  EOF
}

# Automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    profile        = local.profile_name
    encrypt        = true
    bucket         = "tfstate-${local.organization.name}-${local.account_name}-${local.region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    dynamodb_table = "tfstate-lock-${local.organization.name}-${local.account_name}-${local.region}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Configure root level variables that all resources can inherit
inputs = merge(
  local.organization,
  local.account_vars.locals,
  local.region_vars.locals,
)