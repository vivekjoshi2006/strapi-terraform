# 1. Generate RSA Private Key
resource "tls_private_key" "strapi_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Create AWS Key Pair
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.strapi_key.public_key_openssh
}

# 3. Save .pem file locally (Managed by Terraform)
resource "local_file" "private_key" {
  content         = tls_private_key.strapi_key.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0400"
}

# 4. Security Group Configuration
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-security-group"
  description = "Allow Strapi and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH Access
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Strapi Port
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 5. Provision EC2 with Security Group and Strapi Script
resource "aws_instance" "strapi_app" {
  ami                    = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id] # Yaha link kiya hai

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
              sudo apt install -y nodejs
              mkdir -p /srv/strapi
              cd /srv/strapi
              # Automating strapi installation
              npx create-strapi-app@latest my-project --quickstart --no-run
              EOF

  tags = {
    Name = "Strapi-Server-Vivek"
  }
}