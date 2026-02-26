resource "lxd_project" "this" {
  name        = "default"
  description = "Default LXD project"
  config = {
    "features.networks"       = "true"
    "features.networks.zones" = "true"
  }
}

resource "lxd_profile" "this" {
  name        = "default"
  description = "Default LXD profile"
  project     = lxd_project.this.name

  device {
    name = "eth0"
    type = "nic"
    properties = {
      network = "default"
    }
  }

  device {
    name = "root"
    type = "disk"
    properties = {
      path = "/"
      pool = "local"
    }
  }
}

resource "lxd_network" "physical" {
  project = lxd_project.this.name
  name    = "physical"
  type    = "macvlan"
}