resource "tls_private_key" "strapi_key" { algorithm = "RSA"; rsa_bits = 4096 }
resource "aws_key_pair" "deployer" { key_name = "strapi-key"; public_key = tls_private_key.strapi_key.public_key_openssh }
resource "local_file" "private_key" { content = tls_private_key.strapi_key.private_key_pem; filename = "${path.root}/strapi-key.pem" }
output "key_name" { value = aws_key_pair.deployer.key_name }
