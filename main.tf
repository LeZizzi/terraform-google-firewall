/*
    From Google ->
    Note:   Every VPC network has two implied firewall rules. One implied rule allows all egress traffic,
            and the other denies all ingress traffic. You cannot delete the implied rules, but you can override them with your own.
*/

data "google_client_config" "default" {}

# Builds the template for egress
data "external" "egress" {
  program = ["docker", "run", "muvaki/terraform-flatten:0.1.0", "fw", "${local.egress_permissions}"]
}

# Builds the template for ingress
data "external" "ingress" {
  program = ["docker", "run", "muvaki/terraform-flatten:0.1.0", "fw", "--ingress", "${local.ingress_permissions}"]
}

## Block for setting up EGRESS rules
locals {
    # replace is to workaround a terraform bug with not properly jsonecoding integers (fix coming in version 0.12)
    egress_permissions = "${replace(jsonencode(var.egress), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
    egress_deny_all = "${compact(split("|", lookup(data.external.egress.result, "deny_all", "")))}"
    egress_deny_tag = "${compact(split("|", lookup(data.external.egress.result, "deny_tag", "")))}"
    egress_deny_sa = "${compact(split("|", lookup(data.external.egress.result, "deny_sa", "")))}"
    egress_allow_all = "${compact(split("|", lookup(data.external.egress.result, "allow_all", "")))}"
    egress_allow_tag = "${compact(split("|", lookup(data.external.egress.result, "allow_tag", "")))}"
    egress_allow_sa = "${compact(split("|", lookup(data.external.egress.result, "allow_sa", "")))}"

    # Ingress
    # replace is to workaround a terraform bug with not properly jsonecoding integers (fix coming in version 0.12)
    ingress_permissions = "${replace(jsonencode(var.ingress), "/\"([0-9]+\\.?[0-9]*)\"/", "$1")}"
    ingress_deny_all = "${compact(split("|", lookup(data.external.ingress.result, "deny_all", "")))}"
    ingress_deny_tag = "${compact(split("|", lookup(data.external.ingress.result, "deny_tag", "")))}"
    ingress_deny_sa = "${compact(split("|", lookup(data.external.ingress.result, "deny_sa", "")))}"
    ingress_allow_all = "${compact(split("|", lookup(data.external.ingress.result, "allow_all", "")))}"
    ingress_allow_tag = "${compact(split("|", lookup(data.external.ingress.result, "allow_tag", "")))}"
    ingress_allow_sa = "${compact(split("|", lookup(data.external.ingress.result, "allow_sa", "")))}"
}