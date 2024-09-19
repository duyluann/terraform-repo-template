<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_module1"></a> [module1](#module\_module1) | ./modules/module1 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The environment to deploy the resources | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for all resource's names | `string` | `"dev"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the resources | `string` | `"ap-southeast-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
