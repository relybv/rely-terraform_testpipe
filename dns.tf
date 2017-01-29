# Create customer zone
resource "aws_route53_zone" "customer" {
  name = "${var.customer}.${var.domain_base}"
}

# Create environment zone
resource "aws_route53_zone" "environment" {
   name = "${var.environment}.${var.customer}.${var.domain_base}"
}

# Create A record for external load balancer address
resource "aws_route53_record" "ext_lb_name" {
   zone_id = "${var.aws_zone_id}"
   name = "${var.ext_lb_name}.${var.environment}.${var.customer}.${var.domain_base}"
   type = "A"
   ttl = "10"
   records = ["${openstack_compute_floatingip_v2.lb.address}"]
}

# Create NS record for environment
resource "aws_route53_record" "environment-ns" {
   zone_id = "${var.aws_zone_id}"
   name = "${var.environment}.${var.customer}.${var.domain_base}"
   type = "NS"
   ttl = "10"
   records = [
      "${aws_route53_zone.environment.name_servers.0}",
      "${aws_route53_zone.environment.name_servers.1}",
      "${aws_route53_zone.environment.name_servers.2}",
      "${aws_route53_zone.environment.name_servers.3}"
   ]
}
