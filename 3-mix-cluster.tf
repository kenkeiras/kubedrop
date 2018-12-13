# Set the variable value in *.tfvars file
# or using -var="hcloud_token=..." CLI option
variable "hcloud_token" {}
variable "hcloud_ssh_key" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

# Create a server
resource "hcloud_server" "node1" {
  image = "debian-9"
  name = "node1"
  server_type = "cx21"
  ssh_keys = ["${var.hcloud_ssh_key}"]
}

resource "hcloud_server" "node2" {
  image = "debian-9"
  name = "node2"
  server_type = "cx21"
  ssh_keys = ["${var.hcloud_ssh_key}"]
}

resource "hcloud_server" "node3" {
  image = "debian-9"
  name = "node3"
  server_type = "cx21"
  ssh_keys = ["${var.hcloud_ssh_key}"]
}
