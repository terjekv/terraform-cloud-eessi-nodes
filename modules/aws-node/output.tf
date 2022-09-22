output "hostname" {
  description = "The hostname (or prefix if there are multiple hosts)."
  value = var.hostname
}

output "public_ip" {
  description = "The public IP adresses for the terraformed nodes."
  value = aws_instance.node.*.public_ip
}

output "eessi_dns" {
  description = "The DNS names for the terraformed nodes."
  value = aws_route53_record.node.*.name
}

output "private_ip" {
  description = "The private IP adresses for the terraformed nodes."
  value = aws_instance.node.*.private_ip
}

#output "private_key" {
#  description = "The filename of the private key that was generated."
#  value = module.ssh_key_pair.private_key_filename
#}

#output "user_name" {
#  description = "The username for the host to be used with the private key."
#  value = module.image.user_name
#}

output "nodes" {
  description = "The generated node objects."
  value = aws_instance.node.*
}

output "image" {
  description = "The AMI image object."
  value = module.image
}