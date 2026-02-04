output "instance_public_ip" {
  value = module.strapi_server.public_ip
}

output "ssh_command" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${module.strapi_server.public_ip}"
}output "instance_public_ip" {
  value = module.strapi_server.public_ip
}

output "ssh_command" {
  value = "ssh -i ${var.key_name}.pem ubuntu@${module.strapi_server.public_ip}"
}