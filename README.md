# ops-terragrunt
This repo is aimed to be managed by the operators of the project to created resources of aws as code


## How to use

```
# example
# cd accounts/uma/francisco-zafra/iam-user
$ export ACCOUNT=uma
$ export OWNER=francisco-zafra
$ export AWS_REGION=eu-west-3
$ tgrunt run-all plan --terragrunt-source-update
```