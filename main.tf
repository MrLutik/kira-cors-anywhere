terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.28.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_floating_ip" "cors_anywhere_ip" {
  type = "ipv4"
  home_location = "nbg1"  # Replace with your preferred location
}

resource "hcloud_floating_ip_assignment" "cors_anywhere_ip_assignment" {
  floating_ip_id = hcloud_floating_ip.cors_anywhere_ip.id
  server_id      = hcloud_server.cors_anywhere_vm.id
}

resource "hcloud_server" "cors_anywhere_vm" {
  name        = "cors-anywhere-server"
  image       = "ubuntu-20.04"
  server_type = "cx11"
} 

output "ip" {
  value = hcloud_server.cors_anywhere_vm.ipv4_address
}
