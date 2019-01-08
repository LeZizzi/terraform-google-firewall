module "firewalls" {
    source  = "github.com/muvaki/terraform-google-firewall"

    vpc     = "default"
    project = "muvaki-terraform-dummy"

    egress = {
        "allow" = {
            "sa" = {
                description = "sa"
                protocol = "all"
                target_service_accounts = "test@muvaki.com"
                destination_ranges = [
                    "192.160.10.0/24",
                    "10.0.0.0/16"
                ]
            }
        }
        "deny" = {
            "saDeny" = {
                description = "sa"
                protocol = "tcp"
                ports = [443, 9443]
                target_service_accounts = "test2@muvaki.com"
                destination_ranges = ["192.160.10.0/24"]
            }
        }
    }
    ingress = {
        "deny" = {
            "denysa" = {
                description = "tag"
                protocol = "sctp"
                target_service_accounts = "target@muvaki.com"
                source_service_accounts = "source@muvaki.com"
            }
        }
        "allow" = {
            "rangesa" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_service_accounts = "source@muvaki.com"
                source_range = ["192.160.10.0/24"]
            }
            "sourcesa" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_service_accounts = "source@muvaki.com"
            }
        }
    }
}