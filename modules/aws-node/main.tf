resource "aws_instance" "node" {
  count = var.enable ? var.node_count : 0
#  depends_on             = [aws_ebs_volume.home_volume]

  ami                    = local.ami
  instance_type          = var.instance_type != "" ? var.instance_type : local.instance_type
  vpc_security_group_ids = var.security_groups
  subnet_id              = var.subnet_id
  key_name               = module.ssh_key_pair.key_name
  monitoring             = local.monitoring
  availability_zone      = var.availability_zone != "" ? var.availability_zone : local.availability_zone
  user_data              = var.user_data

  associate_public_ip_address = var.public_ip

  root_block_device {
    volume_size = var.volume_size
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }

  tags = {
#    Owner = var.localuser
    Name = "[${ upper(var.environment) }] ${ local.scoped_hostname }"
    Backup = local.backup
    Environment = var.environment
    Monitoring = local.monitoring
  }

#  provisioner "local-exec" {
#    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user -i '${self.ipv4_address},' --private-key ${module.ssh_key_pair.private_key_filename} -e 'pub_key=${module.ssh_key_pair.public_key_filename}' eessi-core.yml"
#  }
}

resource "aws_route53_record" "node" {
  count   = local.enable_dns ? var.node_count : 0
  zone_id = local.dns_zone
  name    = "${ var.hostname }-${count.index}.${ local.subdomain }eessi-infra.org"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.node[count.index].public_ip]
}

#resource "local_file" "node-ssh-documentation" {
#    count    = var.enable ? var.node_count : 0
#    content  = "#!/bin/sh\nssh -oIdentitiesOnly=yes ${ module.image.user_name }@${ aws_instance.node[count.index].public_ip } -i ${ module.ssh_key_pair.private_key_filename	}\n"
#    filename = "${local.keystore}/${var.hostname}-${count.index}.ssh"
#    file_permission = 0755
#}
