terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.44.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}
resource "hcloud_primary_ip" "main" {
  name          = "primary_ip_test"
  datacenter    = "fsn1-dc14"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = {
    "hello" : "world"
  }
}


resource "hcloud_ssh_key" "ssh_pub_key" {
  name       = "ANSIBLE_SSH_PUBLIC_KEY"
  public_key = var.ansible_ssh_public_key
}

resource "hcloud_server" "cors_anywhere_vm" {
  name        = "cors-anywhere-server"
  image       = "ubuntu-20.04"
  server_type = "cax21"
  datacenter  = "fsn1-dc14"
  ssh_keys    = [hcloud_ssh_key.ssh_pub_key.id] 
  public_net {
    ipv4 = hcloud_primary_ip.main.id
  }
} 

output "ip" {
  value = hcloud_server.cors_anywhere_vm.ipv4_address
}
