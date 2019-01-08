module "firewalls" {
    source  = "github.com/muvaki/terraform-google-firewall"

    vpc     = "default"
    project = "muvaki-terraform-dummy"

    egress = {
        "allow" = {
            "range" = {
                description = "sa"
                protocol = "all"
                destination_ranges = [
                    "192.160.10.0/24",
                    "10.0.0.0/16"
                ]
            }
        }
    }
    ingress = {
        "deny" = {
            "denytag" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_range = ["192.160.10.0/24"]
            }
        }
        "allow" = {
            "rangetag" = {
                description = "tag"
                protocol = "all"
                source_range = ["192.160.10.0/24"]
            }
        }
    }
}