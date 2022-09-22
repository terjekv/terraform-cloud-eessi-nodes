module "image" {
    source = "terjekv/ami-search/aws"
    version = "0.0.3"

    os = "rhel"
    architecture = var.arch
}

data "template_file" "user_data" {
  template = file(var.template_file)
}

locals {
    instance_size   = var.instance_size

    scoped_hostname = var.environment == "production" ? var.hostname : "${ var.hostname }.${ var.environment}"

    instance_type   = var.arch == "x86_64" ? "t3.${ local.instance_size }" : "t4g.${ local.instance_size }"
    ami             = var.arch == "x86_64" ? module.image.ami_id : module.image.aws_aarch64.id

    backup          = var.environment == "production" ? "true" : "false"

    homedir         = pathexpand("~")
    dns_zone        = var.environment == "production" ? var.infra_zoneid : var.testing_zoneid
    subdomain       = var.environment == "production" ? "" : "testing."

    keyname         = var.hostname
    keystore        = var.keystore == "" ? "${ local.homedir }/.ssh-eessi/${ var.environment }" : var.keystore

    enable_dns      = var.enable && var.enable_dns ? true : false

    monitoring      = true

    user_data       = var.user_data == "" ? data.template_file.user_data.rendered : var.user_data

    availability_zone = var.environment == "production" ? "eu-west-1a" : "eu-north-1a"
}

variable "keystore" {
    description = "Directory to store the keys generated for the host. Defaults to ~/.eessi-ssh-keys"
    default = ""
}

variable "node_count" {
    description = "Number of nodes to create, defaults to 1"
    type = number
    default = 1
}

variable "user_data" {
    default = ""
    description = "User data to pass to the node (cloud-init data)."
}

variable "public_ip" {
    description = "Give the node a public ip, defaults to false."
    default = false
}

variable "enable" {
    description = "Boolean, create host or not?"
    default = true
}

variable "enable_dns" {
    description = "Boolean, configure DNS under eessi-infra.org or not?"
    default = true
}

variable "hostname" {
    description = "The name of the host to be created."
}

variable "security_groups" {
    description = "A list of the security_groups to apply to the created host."
}

variable "subnet_id" {
    description = "The subnet_id for the node."
    default = ""
  
}

variable "namespace" {
    default = "eessi"
    description = "The project name for this deployment."
}

variable "environment" {
    validation {
        condition = contains(["production", "testing"], var.environment)
        error_message = "Allowed values for environment is 'production' and 'testing'."
    }
    description = "The environment to place the node within (production/testing)."
}

variable instance_size {
    default = "medium"

    validation {
        condition = contains(["small", "medium", "large", "xlarge"], var.instance_size)
        error_message = "Allowed values for instance_size is 'small', 'medium', 'large', and 'xlarge'."
    }
    description = "The instance size desired, ignored if instance_type is set."
}

variable "instance_type" {
    default = ""
    description = "The AWS instance type requested. Must match arch. Overrides instance_size."
}

variable "arch" {
    default = "x86_64"

    validation {
        condition = contains(["x86_64", "aarch64"], var.arch)
        error_message = "Allowed values for arch is 'x86_64' and 'aarch64'."
    }
    description = "The architecture of the node."
}

variable "availability_zone" {
    default = ""
    description = "Availability zone, defaults to eu-west-1a for production and eu-central-1a otherwise."
}

variable "template_file" {
    default = "../../cloud-init/default.yml"
    description = "The template file to use for cloud-init."
}

variable "volume_size" {
    default = 20
    description = "Root disk size in gigabytes, defaults to '20'."
}

variable "testing_zoneid" {
  default = "Z01010092G15QEUB1P5HS"
}

variable "infra_zoneid" {
  default = "Z08669212W005E4G61IF8"
}
