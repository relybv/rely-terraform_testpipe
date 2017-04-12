# specify customer and environment
variable "customer" {
    default = "rely"
}

variable "environment" {
    default = "citest"
}

# specify external domain base
variable "domain_base" {
    default = "openstack.rely.nl"
}

# specify A record name for external load balancer
variable "ext_lb_name" {
    default = "www"
}

/*
# specify AWS credentials as 'export TF_VAR_aws_access_key=<accesskey>; export TF_VAR_aws_secret_key=<secretkey>'
variable "aws_access_key" {}
variable "aws_secret_key" {}
*/

# specify stack user
variable "user_name" {}

# set password as 'export TF_VAR_password=<password>'
variable "password" {}

# generate your own key
variable "ssh_key_file" {
    default = "~/.ssh/id_rsa.rely-citest"
}

# Variables for terraform remote state
variable "swift_bucket_name" {
    default = "terraform-state-rely-citest"
}

variable "swift_region" {
    default = "eu-central-1"
}


############### User definitions ###############
variable "lb_username" {
    default = "ubuntu"
}
variable "monitor_username" {
    default = "ubuntu"
}
variable "appl_username" {
    default = "ubuntu"
}
variable "db_username" {
    default = "ubuntu"
}

############### Hostnames ###############
variable "appl1_hostname" {
    default = "appl1"
}
variable "appl2_hostname" {
    default = "appl2"
}
variable "appl3_hostname" {
    default = "appl3"
}
variable "appl4_hostname" {
    default = "appl4"
}
variable "lb1_hostname" {
    default = "lb1"
}
variable "db1_hostname" {
    default = "db1"
}
variable "monitor1_hostname" {
    default = "monitor1"
}
variable "win1_hostname" {
    default = "win1"
}
############### Fixed IP addresses ###############

variable "main_subnet" {
    default = "172.0.0.0/16"
}
variable "main_net" {
    default = "172.0"
}
variable "monitor1_ip_address" {
    default = "172.0.10.201"
}
variable "lb1_ip_address" {
    default = "172.0.10.51"
}
variable "db1_ip_address" {
    default = "172.0.20.101"
}
variable "db2_ip_address" {
    default = "172.0.20.102"
}
variable "appl1_ip_address" {
    default = "172.0.10.101"
}
variable "appl2_ip_address" {
    default = "172.0.10.102"
}
variable "appl3_ip_address" {
    default = "172.0.10.103"
}
variable "appl4_ip_address" {
    default = "172.0.10.104"
}
variable "win1_ip_address" {
    default = "172.0.20.50"
}

############### security groups ###############
variable "secgroup_front_cidr" {
    default = "172.0.10.0/24"
}
variable "secgroup_back_cidr" {
    default = "172.0.20.0/24"
}

############### NFS mount points appl ###############
variable "appl_error_mount" {
    default = "/mnt/nfs/errors"
}
variable "appl_config_mount" {
    default = "/mnt/nfs/config"
}
variable "appl_template_mount" {
    default = "/mnt/nfs/office-templates"
}
variable "appl_log_mount" {
    default = "/mnt/nfs/logs"
}

############### NFS exports points db ###############
variable "db_error_export" {
    default = "/mnt/nfs/errors"
}
variable "db_config_export" {
    default = "/mnt/nfs/config"
}
variable "db_template_export" {
    default = "/mnt/nfs/office-templates"
}
variable "db_log_export" {
    default = "/mnt/nfs/logs"
}

############### adjust as needed ###############
variable "db_vol_gb" {
    default = 100
}
variable "nfs_vol_gb" {
    default = 10
}
variable "es_vol_gb" {
    default = 100
}

############### Environment settings for Rely_openstack DirICT ###################
variable "tenant_name" {
    default = "lab"
}

variable "auth_url" {
    default = "https://access.openstack.rely.nl:5000/v2.0"
}

variable "region" {
    default = "RegionOne"
}

variable "external_gateway" {
    default = "2613fe91-7fa1-4033-8fd3-678e7e9e15e7"
}

variable "pool" {
    default = "external"
}

variable "image_deb" {
    default = "Ubuntu 14.04 LTS"
}

variable "image_ub" {
    default = "Ubuntu 14.04 LTS"
}

variable "image_win" {
    default = "Windows Server 2012 R2 Std Eval"
}

variable "voll_win" {
    default = "06590db3-e4c2-4984-a2c9-ca8354b86a76"
}

variable "flavor_appl" {
    default = "ha_localdisk.4c.16r.60h"
}

variable "flavor_db" {
    default = "ha_localdisk.4c.16r.60h"
}

variable "flavor_mon" {
    default = "ha_localdisk.2c.4r.20h"
}

variable "flavor_win" {
    default = "ha_localdisk.2c.4r.60h"
}

variable "flavor_lb" {
    default = "ha_localdisk.1c.1r.20h"
}

