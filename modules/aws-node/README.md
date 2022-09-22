# Core node configuration for EESSI

This module allows for easy configuration of AWS nodes used by the [EESSI](https://eessi-hpc.org) project. 

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_image"></a> [image](#module\_image) | terjekv/ami-search/aws | 0.0.3 |
| <a name="module_ssh_key_pair"></a> [ssh\_key\_pair](#module\_ssh\_key\_pair) | cloudposse/key-pair/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_route53_record.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [local_file.node-ssh-documentation](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arch"></a> [arch](#input\_arch) | The architecture of the node. | `string` | `"x86_64"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability zone, defaults to eu-west-1a for production and eu-central-1a otherwise. | `string` | `""` | no |
| <a name="input_aws_route53_infra_testing_zoneid"></a> [aws\_route53\_infra\_testing\_zoneid](#input\_aws\_route53\_infra\_testing\_zoneid) | n/a | `string` | `"Z01010092G15QEUB1P5HS"` | no |
| <a name="input_aws_route53_infra_zoneid"></a> [aws\_route53\_infra\_zoneid](#input\_aws\_route53\_infra\_zoneid) | n/a | `string` | `"Z08669212W005E4G61IF8"` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Boolean, create host or not? | `bool` | `true` | no |
| <a name="input_enable_dns"></a> [enable\_dns](#input\_enable\_dns) | Boolean, configure DNS under eessi-infra.org or not? | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to place the node within (production/testing). | `any` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The name of the host to be created. | `any` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | The instance size desired, ignored if instance\_type is set. | `string` | `"medium"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The AWS instance type requested. Must match arch. Overrides instance\_size. | `string` | `""` | no |
| <a name="input_keystore"></a> [keystore](#input\_keystore) | Directory to store the keys generated for the host. Defaults to ~/.eessi-ssh-keys | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The project name for this deployment. | `string` | `"eessi"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes to create, defaults to 1 | `number` | `1` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | Give the node a public ip, defaults to false. | `bool` | `false` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of the security\_groups to apply to the created host. | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet\_id for the node. | `string` | `""` | no |
| <a name="input_template_file"></a> [template\_file](#input\_template\_file) | The template file to use for cloud-init, defaults to ../cloud-init/${ var.hostname }.yaml | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to pass to the node (cloud-init data). | `any` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Root disk size in gigabytes, defaults to '20'. | `number` | `20` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eessi_dns"></a> [eessi\_dns](#output\_eessi\_dns) | The DNS names for the terraformed nodes |
| <a name="output_hostname"></a> [hostname](#output\_hostname) | The hostname (or prefix if there are multiple hosts) |
| <a name="output_image"></a> [image](#output\_image) | The AMI image object. |
| <a name="output_nodes"></a> [nodes](#output\_nodes) | The generated node objects. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP adresses for the terraformed nodes |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | The filename of the private key that was generated |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP adresses for the terraformed nodes |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The username for the host to be used with the private key. |
<!-- END_TF_DOCS -->