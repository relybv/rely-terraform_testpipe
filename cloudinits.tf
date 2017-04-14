# Template for lb cloud-init bash
data "template_file" "init_lb" {
    template = "${file("init_lb.tpl")}"
    vars {
        appl1_address = "${var.appl1_ip_address}"
        appl2_address = "${var.appl2_ip_address}"
        appl3_address = "${var.appl3_ip_address}"
        appl4_address = "${var.appl4_ip_address}"
        appl1_name = "${var.appl1_hostname}"
        appl2_name = "${var.appl2_hostname}"
        appl3_name = "${var.appl3_hostname}"
        appl4_name = "${var.appl4_hostname}"
        monitor_address = "${var.monitor1_ip_address}"
    }
}

# Template for appl cloud-init bash
data "template_file" "init_appl" {
    template = "${file("init_appl.tpl")}"
    vars {
        monitor_address = "${var.monitor1_ip_address}"
        nfs_address = "${var.db1_ip_address}"
        db_address = "${var.db1_ip_address}"
        win_address = "${var.win1_ip_address}"
        ext_lb_fqdn = "${var.ext_lb_name}.${var.environment}.${var.customer}.${var.domain_base}"
    }
}

# Template for db cloud-init bash
data "template_file" "init_db" {
    template = "${file("init_db.tpl")}"
    vars {
        monitor_address = "${var.monitor1_ip_address}"
        db_export_net = "${var.main_subnet}"
    }
}

# Template for monitor cloud-init bash
data "template_file" "init_monitor" {
    template = "${file("init_monitor.tpl")}"
}

# Template for win cloud-init powershell
data "template_file" "init_win" {
    template = "${file("init_win.tpl")}"
    vars {
        monitor_address = "${var.monitor1_ip_address}"
    }
}
