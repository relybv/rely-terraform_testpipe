resource "openstack_compute_secgroup_v2" "terraform" {
  name = "terraform_${var.customer}_${var.environment}_global"
  region = "${var.region}"
  description = "Security group for the Terraform instances"
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "udp"
    cidr = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "icmp"
    from_port = "-1"
    to_port = "-1"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "frontnet" {
  name = "terraform_${var.customer}_${var.environment}_frontnet"
  region = "${var.region}"
  description = "Security group for the frontnet instances"
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "udp"
    cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    ip_protocol = "icmp"
    from_port = "-1"
    to_port = "-1"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "backnet" {
  name = "terraform_${var.customer}_${var.environment}_backnet"
  region = "${var.region}"
  description = "Security group for the backnet instances"
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "udp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    ip_protocol = "icmp"
    from_port = "-1"
    to_port = "-1"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "lb" {
  name = "terraform_${var.customer}_${var.environment}_lb"
  region = "${var.region}"
  description = "Security group for the loadbalancer instances"
  rule {
    from_port = 80
    to_port = 81
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
      from_port = 1
      to_port = 65535
      ip_protocol = "tcp"
      cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    ip_protocol = "icmp"
    from_port = "-1"
    to_port = "-1"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "monitor" {
  name = "terraform_${var.customer}_${var.environment}_monitor"
  region = "${var.region}"
  description = "Security group for the Monitor instances"
  rule {
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 4440
    to_port = 4440
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 3000
    to_port = 3000
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "tcp"
    cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "udp"
    cidr = "${var.secgroup_front_cidr}"
  }
  rule {
    from_port = 1
    to_port = 65535
    ip_protocol = "udp"
    cidr = "${var.secgroup_back_cidr}"
  }
  rule {
    ip_protocol = "icmp"
    from_port = "-1"
    to_port = "-1"
    cidr = "0.0.0.0/0"
  }
}
