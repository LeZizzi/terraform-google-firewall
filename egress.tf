#####################################
#            EGRESS DENY            #
#####################################
resource "google_compute_firewall" "egress_deny_all" {

    count                   = "${length(local.egress_deny_all) > 0 ? length(local.egress_deny_all) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-deny-${chomp(element(split("==", local.egress_deny_all[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_deny_all[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_all[count.index]), 1)), 1)))}"]

    deny {
        protocol            = "${element(split(",", element(split("==", local.egress_deny_all[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_all[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_deny_all[count.index]), 1)), 4)}"
}

resource "google_compute_firewall" "egress_deny_tag" {

    count                   = "${length(local.egress_deny_tag) > 0 ? length(local.egress_deny_tag) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-deny-${chomp(element(split("==", local.egress_deny_tag[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 1)))}"]

    deny {
        protocol            = "${element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 4)}"
    target_tags             = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_tag[count.index]), 1)), 5)))}"]
}

resource "google_compute_firewall" "egress_deny_sa" {

    count                   = "${length(local.egress_deny_sa) > 0 ? length(local.egress_deny_sa) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-deny-${chomp(element(split("==", local.egress_deny_sa[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 1)))}"]

    deny {
        protocol            = "${element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 4)}"
    target_service_accounts = ["${compact(list(element(split(",", element(split("==", local.egress_deny_sa[count.index]), 1)), 5)))}"]
}

#####################################
#            EGRESS ALLOW           #
#####################################
resource "google_compute_firewall" "egress_allow_all" {

    count                   = "${length(local.egress_allow_all) > 0 ? length(local.egress_allow_all) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-allow-${chomp(element(split("==", local.egress_allow_all[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_allow_all[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_all[count.index]), 1)), 1)))}"]

    allow {
        protocol            = "${element(split(",", element(split("==", local.egress_allow_all[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_all[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_allow_all[count.index]), 1)), 4)}"
}

resource "google_compute_firewall" "egress_allow_tag" {

    count                   = "${length(local.egress_allow_tag) > 0 ? length(local.egress_allow_tag) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-allow-${chomp(element(split("==", local.egress_allow_tag[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 1)))}"]

    allow {
        protocol            = "${element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 4)}"
    target_tags             = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_tag[count.index]), 1)), 5)))}"]
}

resource "google_compute_firewall" "egress_allow_sa" {

    count                   = "${length(local.egress_allow_sa) > 0 ? length(local.egress_allow_sa) : 0}"

    project                 = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    network                 = "${var.vpc}"
    direction               = "EGRESS"

    name                    = "${var.vpc}-allow-${chomp(element(split("==", local.egress_allow_sa[count.index]), 0))}"
    description             = "${element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 0)}"

    destination_ranges      = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 1)))}"]

    allow {
        protocol            = "${element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 2)}"
        ports               = ["${compact(split("+", element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 3)))}"]
    }

    priority                = "${element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 4)}"
    target_service_accounts = ["${compact(list(element(split(",", element(split("==", local.egress_allow_sa[count.index]), 1)), 5)))}"]
}
