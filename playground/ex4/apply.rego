package terraform.analysis

import input as tfplan

########################
# Parameters for Policy
########################

# acceptable score for automated authorization
blast_radius := 30

# weights assigned for each operation on each resource-type
weights := {
    "aws_autoscaling_group": {"delete": 100, "create": 10, "modify": 1},
    "aws_instance": {"delete": 10, "create": 1, "modify": 1}
}

# Consider exactly these resource types in calculations
resource_types := {"aws_autoscaling_group", "aws_instance", "aws_iam", "aws_launch_configuration"}

#########
# Policy
#########

# Authorization holds if score for the plan is acceptable and no changes are made to IAM
default authz = false
authz {
    score < blast_radius
    not touches_iam
}

# Compute the score for a Terraform plan as the weighted sum of deletions, creations, modifications
score = s {
    all := [ x |
            some resource_type
            crud := weights[resource_type];
            del := crud["delete"] * num_deletes[resource_type];
            new := crud["create"] * num_creates[resource_type];
            mod := crud["modify"] * num_modifies[resource_type];
            x := del + new + mod
    ]
    s := sum(all)
    # print(s)
}

# Whether there is any change to IAM
touches_iam {
    all := resources["aws_iam"]
    count(all) > 0
}

####################
# Terraform Library
####################

# list of all resources of a given type
resources[resource_type] = all {
    some resource_type
    resource_types[resource_type]
    all := [name |
        name:= tfplan.resource_changes[_]
        name.type == resource_type
    ]
}

# number of creations of resources of a given type
num_creates[resource_type] = num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    creates := [res |  res:= all[_]; res.change.actions[_] == "create"]
    num := count(creates)
}


# number of deletions of resources of a given type
num_deletes[resource_type] = num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    deletions := [res |  res:= all[_]; res.change.actions[_] == "delete"]
    num := count(deletions)
}

# number of modifications to resources of a given type
num_modifies[resource_type] = num {
    some resource_type
    resource_types[resource_type]
    all := resources[resource_type]
    modifies := [res |  res:= all[_]; res.change.actions[_] == "update"]
    num := count(modifies)
}

# `allow` is a "rule". The simplest kind of rules in Rego are "if-then" statements
# that assign a single value to a variable. If the value is omitted, it defaults to `true`.
# In other words, this rule is equivalent to:
#
#	allow = true {
#		score < blast_radius
#	}
#
# Since statements like `X = true { ... }` are so common, Rego lets you omit the `= true` bit.
#
# This rule says (in English):
#
#	allow is true if...
#		score is less then blast radidus is "GET"
#
# The statements in the body of the rule are AND-ed together.
allow {
	score < blast_radius
}
