# Terraform Compute Firewall Module
A opinionated Terraform module that helps manage Project API's and control IAM permissions authoritatively at the Project Level


Supports following:
- Allow/Deny Rules for Ingress using Service Accounts, Tags and Ranges
- Allow/Deny Rules for Egress using Service Accounts, Tags and Ranges

Future Consideration:
- Lot of these features will be made easier to implement with 0.12.0 and possibly element the use of terraform-flatten

## Prerequisite
This module uses docker to flatten IAM permissions passed down to module. Ensure that you have docker installed as it uses [terraform-flatten](https://hub.docker.com/r/muvaki/terraform-flatten) image to flatten the IAM Map. Information about the image can be found [here](https://github.com/muvaki/terraform-flatten)

## Usage
Example folder covers how to Manage Firewalls for different use cases. Sample config:

```hcl
module "firewall" {
    source  = "github.com/muvaki/terraform-google-firewall"

    vpc     = "default"
    project = "muvaki-terraform-dummy"

    ingress = {
        "allow" = {
            "range" = {
                description = "sa"
                protocol = "all"
                source_ranges = [
                    "192.160.10.0/24",
                    "10.0.0.0/16"
                ]
            }
            "sa" = {
                description = "sa"
                protocol = "tcp"
                ports = [443, 80]
                source_service_account = "source@test.com",
                source_ranges = [
                    "192.160.10.0/24",
                    "10.0.0.0/16"
                ]
            }
        }
    }
    egress = {
        "deny" = {
            "tag" = {
                description = "tag"
                protocol = "tcp"
                ports = [443, 80]
                source_tags = [
                    "test1",
                    "test2"
                ],
                target_tags = [
                    "target-tag1",
                    "target-tag2"
                ]
            }
        }
    }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Project ID... inferred by provider if not explicitly set  | string. | "" | no |
| vpc | VPC to which the FW rules belong to| string | | yes |
| module_dependency | Pass an output from another variable/module to create dependency | string | "" | no |
| egress |  set of egress allow/deny rules | map | {} | no |
| ingress | set of ingress allow/deny rules| map | {} | no |

### Egress Inputs

Top level map starts with "allow" or "deny" followed by maps of firewall names and options specified below.

```hcl
egress = {
    "allow" = {
        "fw-name-1" = {
            ...
        }
    },
    "deny" = {
        "fw-name-2" = {
            ...
        }
    }
}
```

| Name | Description | Type | Pattern | Default | Required | Conflict |
|------|-------------|:----:|:-------:|:-------:|:--------:|:--------:|
| description | FW Rule Description | string | "\^[a-zA-Z0-9 \\-_]*$" | - | no | - |
| protocol | Protocol to define  | string| tcp,udp,icmp,esp,ah,sctp,all or any Protocol number | - | yes | - |
| ports |  Ports that apply for the permission. This is required if protocol is either tcp/udp | integer | 0-65535 | - | no | - |
| disabled | Weather to disable firewall rule | string | "true or false" | false | no | - |
| priority | Relative priorities determine precedence of conflicting rules. Lower value of priority implies higher precedence | integer | 0-65535 | 1000 | no | - |
| destination_ranges | if destination ranges are specified, the firewall will apply only to traffic that has destination IP address in these ranges | list | IPv4 CIDR (string) | - | no | - |
| target_service_account | A service Account located in the network that may make network connections as specified. | string | email address | - | no | target_tags |
| target_tags | A list of instance tags indicating set of instances located in the network that may make network connections as specified | list | text | - | no | target_service_account |

### Ingress Inputs

Top level map starts with "allow" or "deny" followed by maps of firewall names and options specified below.

```hcl
ingress = {
    "allow" = {
        "fw-name-1" = {
            ...
        }
    },
    "deny" = {
        "fw-name-2" = {
            ...
        }
    }
}
```

#### Ingress

| Name | Description | Type | Pattern | Default | Required | Conflict |
|------|-------------|:----:|:-------:|:-------:|:--------:|:--------:|
| description | FW Rule Description | string | "\^[a-zA-Z0-9 \\-_]*$" | - | no | - |
| protocol | Protocol to define  | string| tcp,udp,icmp,esp,ah,sctp,all or any Protocol number | - | yes | - |
| ports |  Ports that apply for the permission. This is required if protocol is either tcp/udp | integer | 0-65535 | - | no | - |
| disabled | Weather to disable firewall rule | string | "true or false" | false | no | - |
| priority | Relative priorities determine precedence of conflicting rules. Lower value of priority implies higher precedence | integer | 0-65535 | 1000 | no | - |
| source_ranges | If source ranges are specified, the firewall will apply only to traffic that has source IP address in these ranges | list | IPv4 CIDR (string) | - | no | - |
| target_service_account | A service Account located in the network that may make network connections as specified. | string | email address | - | no | target_tags, source_tags |
| source_service_account | If source service accounts are specified, the firewall will apply only to traffic originating from an instance with attached service account. | string | email address | - | no | target_tags, source_tags |
| target_tags | A list of instance tags indicating set of instances located in the network that may make network connections as specified | list | text | - | no | target_service_account, source_service_account |
| source_tags |  If source tags are specified, the firewall will apply only to traffic with source IP that belongs to a tag listed in source tags | list | text | - | no | target_service_account, source_service_account |

## Outputs

Outputs in this module currently are only used for debugging purposes.

| Name | Description | 
|------|-------------|
| egress_value | result of the flattened map returned from terraform-flatten for egress|
| egress_result | json encoded egress variable passed to terraform-flatten |
| ingress_value | result of the flattened map returned from terraform-flatten for ingress|
| ingress_result | json encoded ingress variable passed to terraform-flatten |


## Docs:

module reference docs: 
- terraform.io (v0.11.11)
- GCP [Firewalls](https://cloud.google.com/vpc/docs/firewalls)
- Muvaki [Terraform Flatten](https://github.com/muvaki/terraform-flatten)

### LICENSE

MIT License