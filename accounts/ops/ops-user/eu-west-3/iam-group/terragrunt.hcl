locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).inputs
}


terraform {
  source = "git@github.com:andresanaya21/5gplustactile/auto-ztp.git//tf-modules/iam-group?ref=main"
}
# Include all settings from the root terragrunt.hcl file

include {
  path = find_in_parent_folders()
}

inputs = merge(local.environment_vars,
  {
   policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
   ]
   name_group = "uma"
})