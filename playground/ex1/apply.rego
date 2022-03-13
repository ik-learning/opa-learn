package terraform

import input as tfplan

apply {
	not deletes_s3_bucket
	not deletes_kms_key
}

deletes_s3_bucket {
	deleted := deletions("aws_s3_bucket")
	count(deleted) > 0
}

deletes_kms_key {
	deleted := deletions("aws_kms_key")
	count(deleted) > 0
}

# list of all resources of a given type
resources(resource_type) = all {
	all := [res |
		res := tfplan.resource_changes[_]
		res.type == resource_type
	]
}

# list resources being deleted
deletions(resource_type) = deletions {
	all := resources(resource_type)
	deletions := [res |
		res := all[_]
		res.change.actions[_] == "delete"
	]
}
