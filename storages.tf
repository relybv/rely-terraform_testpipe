resource "openstack_blockstorage_volume_v1" "db1" {
  name = "db1-volume_${var.customer}_${var.environment}"
  region = "${var.region}"
  description = "database volume Customer ${var.customer} Environment ${var.environment}"
  size = "${var.db_vol_gb}"
}

resource "openstack_blockstorage_volume_v1" "nfs1" {
  name = "nfs1-volume_${var.customer}_${var.environment}"
  region = "${var.region}"
  description = "nfs volume Customer ${var.customer} Environment ${var.environment}"
  size = "${var.nfs_vol_gb}"
}

resource "openstack_blockstorage_volume_v1" "es1" {
  name = "es1-volume_${var.customer}_${var.environment}"
  region = "${var.region}"
  description = "elasticsearch volume Customer ${var.customer} Environment ${var.environment}"
  size = "${var.es_vol_gb}"
}
