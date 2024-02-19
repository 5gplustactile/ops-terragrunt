locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl")).inputs
}


terraform {
  source = "git@github.com:andresanaya21/5gplustactile/auto-ztp.git//tf-modules/iam-user?ref=main"
}
# Include all settings from the root terragrunt.hcl file

include {
  path = find_in_parent_folders()
}

inputs = merge(local.environment_vars,
  {
    name                    = "${local.environment_vars.owner}"
    role_name               = ""
    role_description        = ""
    force_destroy           = false
    create_iam_access_key   = true
    password_reset_required = true
    aws_account_id          = "${local.environment_vars.account_id}"
    user_groups = [
      { name = "uma" }
    ]
    default_policies = ["AmazonS3OutpostsReadOnlyAccess"]
    policies = [
      {
        name = "OutpostPolicy-francisco-luque-schempp"
        policy_as_object = {
          Version = "2012-10-17"
          Statement = [
              {
                  "Effect": "Allow",
                  "Action": [
            				"outposts:ListCatalogItems",
            				"outposts:GetOrder",
            				"outposts:GetCatalogItem",
            				"outposts:GetOutpost",
            				"outposts:GetOutpostInstanceTypes",
            				"outposts:GetSite",
            				"outposts:ListOrders",
            				"outposts:ListAssets",
            				"outposts:GetSiteAddress",
            				"outposts:ListTagsForResource",
            				"outposts:ListSites",
            				"outposts:ListOutposts",
            				"outposts:GetPrivateConnectivityConfig",
            				"outposts:GetConnection",
                    "outposts:StartConnection"
                  ],
                  "Resource": "arn:aws:outposts:eu-west-3:${local.environment_vars.account_id}:outpost/*"
              },
              {
                  "Effect": "Allow",
                  "Action": [
                      "cloudwatch:GetMetricData"
                  ],
                  "Resource": "*"
              }
          ]
         }
      }
    ]
})