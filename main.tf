module "ssh_key" {
  source = "./modules/ssh-key"
}

module "compute" {
  source    = "./modules/compute"
  key_name  = module.ssh_key.key_name
}
