locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).inputs
}


terraform {
  source = "git@github.com:andresanaya21/5gplustactile/auto-ztp.git//tf-modules//budget?ref=main"
}
# Include all settings from the root terragrunt.hcl file

include {
  path = find_in_parent_folders()
}

inputs = merge(local.environment_vars,
  {
    budget_name                       = "Tactile5G"
    limit_amount                      = 800
    limit_unit                        = "USD"
    direct_subscriber_email_addresses = ["alvaroandres.anayaamariles@telefonica.com","jesus.maciasportela@telefonica.com"]
    tagkey                            = "project"
    tagkeyvalue                       = "tactile5g"
})