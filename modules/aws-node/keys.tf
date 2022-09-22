module "ssh_key_pair" {
  source = "cloudposse/key-pair/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace             = var.namespace
  name                  = local.keyname
  ssh_public_key_path   = local.keystore
  ssh_key_algorithm     = "RSA"
  generate_ssh_key      = "true"
  public_key_extension  = ".pub"
  tags                  = {
    "Environment": var.environment,
    "Owner": "terraform",
   }
}