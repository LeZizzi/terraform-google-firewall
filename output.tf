# These outputs are used more for debugging

# Stores value for Egress input
output "egress_value" {
  value = "${local.egress_permissions}"
}

# Stores value for the Egress flattened map
output "egress_result" {
  value = "${data.external.egress.result}"
}

# Stores value for Ingress input
output "ingress_value" {
  value = "${local.ingress_permissions}"
}

# Stores value for the Ingress flattened map
output "ingress_result" {
  value = "${data.external.ingress.result}"
}