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

resource "hcloud_server" "cors_anywhere_vm" {
  name        = "cors-anywhere-server"
  image       = "ubuntu-20.04"
  server_type = "cx11"
} 

output "ip" {
  value = hcloud_server.cors_anywhere_vm.ipv4_address
}
