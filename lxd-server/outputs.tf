output "runner_ip" {
  value = lxd_instance.runner.ipv4_address
}

output "ansible_ip" {
  value = lxd_instance.ansible.ipv4_address
}
