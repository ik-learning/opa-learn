# https://www.infralovers.com/blog/2024-06-28-terraform-opa-policies/
# https://www.infralovers.com/blog/2024-06-28-terraform-opa-policies/
package terraform.module


import rego.v1

import input as tfplan


disallowed_cidrs := ["0.0.0.0/0", "::/0"]


deny contains msg if {
    r := tfplan.resource_changes[_]
    r.type in ["aws_security_group_rule", "aws_security_group"]
    valid_port(r.change.after.ingress[_])
    invalid_cidr(r.change.after.ingress[_])
    msg := sprintf("%v has 0.0.0.0/0 as allowed ingress for SSH / Port 22", [r.address])
}


valid_port(ingress) if ingress.from_port == 22
valid_port(ingress) if ingress.to_port == 22
invalid_cidr(ingress) if ingress.cidr_blocks[_] in disallowed_cidrs
invalid_cidr(ingress) if ingress.ipv6_cidr_blocks[_] in disallowed_cidrs
