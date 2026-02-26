resource "lxd_instance" "master" {
  remote = local.remote

  name  = "master"
  image = local.image
  type  = "virtual-machine"

  limits = {
    memory = "4GiB"
    cpu    = 2
  }

  config = {
    "user.user-data" = <<-EOT
      #cloud-config
      ssh_authorized_keys:
        - ${data.local_file.ssh_key.content}
    EOT
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

  config = {
    "user.user-data" = <<-EOT
      #cloud-config
      ssh_authorized_keys:
        - ${data.local_file.ssh_key.content}
    EOT
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

  name  = "static-runner"
  image = local.image
  type  = "virtual-machine"

  limits = {
    memory = "2GiB"
    cpu    = 2
  }

  config = {
    "user.user-data" = <<-EOT
      #cloud-config
      ssh_authorized_keys:
        - ${data.local_file.ssh_key.content}
    EOT
  }

  device {
    name = "eth-1"
    type = "nic"
    properties = {
      "network" = lxd_network.physical.name
    }
  }
}

resource "lxd_instance" "ansible" {
  remote = local.remote

  name  = "ansible-lab"
  image = local.image
  type  = "virtual-machine"

  limits = {
    memory = "2GiB"
    cpu    = 2
  }

  config = {
    "user.user-data" = <<-EOT
      #cloud-config
      ssh_authorized_keys:
        - ${data.local_file.ssh_key.content}
    EOT
  }

  device {
    name = "eth-1"
    type = "nic"
    properties = {
      "network" = lxd_network.physical.name
    }
  }
}