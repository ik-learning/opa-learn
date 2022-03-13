package terraform


test_empty_allowed {
	apply with input as {}
}

test_new_tenant_allowed {
	apply with input as data.fixtures.apply_new_tenant
}

test_no_changes_allowed {
	apply with input as data.fixtures.apply_no_changes
}

test_s3_delete_denied {
	not apply with input as data.fixtures.apply_with_s3_delete
}

test_kms_delete_denied {
	not apply with input as data.fixtures.apply_with_kms_delete
}
