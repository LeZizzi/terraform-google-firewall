module "firewalls" {
    source  = "github.com/muvaki/terraform-google-firewall"

    vpc     = "default"
    project = "muvaki-terraform-dummy"

    egress = {
        "allow" = {
            "tag" = {
                description = "sa"
                protocol = "all"
                target_tags = ["tagtest"]
                destination_ranges = [
                    "192.160.10.0/24",
                    "10.0.0.0/16"
                ]
            }
        }
        "deny" = {
            "tagDeny" = {
                description = "sa"
                protocol = "tcp"
                ports = [443, 9443]
                target_tags = ["denytag", "moredeny"]
                destination_ranges = ["192.160.10.0/24"]
            }
        }
    }
    ingress = {
        "deny" = {
            "denytag" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                target_tags = [
                    "target-tag1",
                    "target-tag2"
                ]
                source_tags = [
                    "test1",
                    "test2"
                ]
            }
        }
        "allow" = {
            "rangetag" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_tags = [
                    "tag1",
                    "tag2"
                ]
                source_range = ["192.160.10.0/24"]
            }
            "sourcetag" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_tags = ["source-tag1",]
            }
        }
    }
}