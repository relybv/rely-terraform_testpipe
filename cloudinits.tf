# Template for lb cloud-init bash
resource "template_file" "init_lb" {
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
resource "template_file" "init_appl" {
    template = "${file("init_appl.tpl")}"
    vars {
        test = "test"
    }
}

# Template for monitor cloud-init bash
resource "template_file" "init_monitor" {
    template = "${file("init_monitor.tpl")}"
    vars {
        test = "test"
    }
}

