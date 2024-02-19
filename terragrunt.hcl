locals {
    account        = get_env("ACCOUNT")
    project        = "tactile5g"
    owner          = get_env("OWNER")
    default_region =  "eu-west-3"
    region         =  get_env("AWS_REGION")
    account_id = "774986117405"
    environment_vars = read_terragrunt_config("${get_parent_terragrunt_dir()}/accounts/${local.account}/${local.owner}/${local.region}/environment.hcl")

}

inputs = {
    account        = local.account
    project        = local.project
    owner          = local.owner
    account_id     = local.account_id
    region         = local.region
    default_region = local.default_region   
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "${local.project}-ops-tf-state-${local.region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "${local.project}-ops-tf-locks-${local.region}"
  
  s3_bucket_tags = {
    name        = "Terraform Remote State"
    project     = local.project
    owner       = local.owner
    region      = local.region
    managed     = "terraform"
  }
  dynamodb_table_tags = {
    name        = "Terraform Remote State"
    project     = local.project
    owner       = local.owner
    region      = local.region
    managed     = "terraform"
  }
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
generate "provider" {
  path      = "global_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("globals/provider.tf")
}

generate "global_variables" {
  path      = "global_variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("globals/variables.tf")
}

generate "versions" {
  path              = "versions.tf"
  if_exists         = "skip"
  disable_signature = "true"
  contents          = file("globals/versions.tf")
}
