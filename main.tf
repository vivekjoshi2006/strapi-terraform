provider "aws" {
  region = "us-east-1"
}

module "strapi_server" {
  source        = "./modules/ec2_instance"
  instance_type = "t3.small" # Strapi recommends at least 2GB RAM
  key_name      = "strapi-key"
}