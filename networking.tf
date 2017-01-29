#
# Network definitions
#
resource "openstack_networking_network_v2" "frontend" {
  name = "frontend_${var.customer}_${var.environment}"
  region = "${var.region}"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "backend" {
  name = "backend_${var.customer}_${var.environment}"
  region = "${var.region}"
  admin_state_up = "true"
}

#
# Subnet definitions
#
resource "openstack_networking_subnet_v2" "frontend" {
  name = "frontend_${var.customer}_${var.environment}"
  region = "${var.region}"
  network_id = "${openstack_networking_network_v2.frontend.id}"
  cidr = "${var.secgroup_front_cidr}"
  ip_version = 4
  enable_dhcp = "true"
  dns_nameservers = ["8.8.8.8","8.8.4.4"]
}

resource "openstack_networking_subnet_v2" "backend" {
  name = "backend_${var.customer}_${var.environment}"
  region = "${var.region}"
  network_id = "${openstack_networking_network_v2.backend.id}"
  cidr = "${var.secgroup_back_cidr}"
  ip_version = 4
  enable_dhcp = "true"
  dns_nameservers = ["8.8.8.8","8.8.4.4"]
}

#
# Router definitions
#
resource "openstack_networking_router_v2" "terraform" {
  name = "terraform_${var.customer}_${var.environment}"
  region = "${var.region}"
  admin_state_up = "true"
  external_gateway = "${var.external_gateway}"
}

#
# Router interface definitions
#
resource "openstack_networking_router_interface_v2" "frontend" {
  region = "${var.region}"
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.frontend.id}"
}

resource "openstack_networking_router_interface_v2" "backend" {
  region = "${var.region}"
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.backend.id}"
}
