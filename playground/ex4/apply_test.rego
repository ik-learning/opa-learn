package terraform.analysis

# This test will pass.
test_empty_allowed {
	score with input as {}
}

test_can_calculate_score {
	score with input as data.fixtures.base
}

test_allow_auto_merge {
	allow with input as data.fixtures.base
}
