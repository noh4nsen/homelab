terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "2.6.2"
    }
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  remote {
    name    = local.remote
    address = var.lxd_server
    token   = var.lxd_token
    default = true
  }
}
