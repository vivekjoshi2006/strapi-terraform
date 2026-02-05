variable "key_name" {}
resource "aws_instance" "strapi_server" { ami = "ami-0c55b159cbfafe1f0"; instance_type = "t2.micro"; key_name = var.key_name }
output "public_ip" { value = aws_instance.strapi_server.public_ip }
