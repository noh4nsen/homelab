resource "lxd_instance" "master" {
  remote = local.remote

  name  = "master"
  image = local.image
  type  = "virtual-machine"

  limits = {
    memory = "4GiB"
    cpu    = 2
  }

  device {
    name = "eth-1"
    type = "nic"
    properties = {
      "network" = lxd_network.physical.name
    }
  }
}

resource "lxd_instance" "worker" {
  count  = 2
  remote = local.remote

  name  = "worker-${count.index}"
  image = local.image
  type  = "virtual-machine"

  allow_restart = true

  limits = {
    memory = "2GiB"
    cpu    = 2
  }

  device {
    name = "eth-1"
    type = "nic"
    properties = {
      "network" = lxd_network.physical.name
    }
  }
}

resource "lxd_instance" "runner" {
  remote = local.remote

  name  = "runner"
  image = local.image
  type  = "virtual-machine"

  limits = {
    memory = "2GiB"
    cpu    = 2
  }

  device {
    name = "eth-1"
    type = "nic"
    properties = {
      "network" = lxd_network.physical.name
    }
  }
}

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