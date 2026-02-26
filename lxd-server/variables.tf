variable "lxd_token" {
  description = "Token for LXD server authentication"
  type        = string
  sensitive   = true
}

variable "lxd_server" {
  description = "URL of the LXD server"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the SSH public key"
  type        = string
}