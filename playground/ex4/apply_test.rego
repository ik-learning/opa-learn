package terraform.analysis

# This test will pass.
test_empty_allowed {
	score with input as {}
}

test_can_calculate_score {
	score with input as data.fixtures.base
}

test_should_score_be_calculated {
	result = score with input as data.fixtures.base
    result == 11
}

test_shoul_have_fetch_resources {
    result = resources with input as data.fixtures.base
    # print(count(result))
    count(result) = 4
}

test_shoul_have_fetch_deleted_resources {
    result = num_deletes with input as data.fixtures.base
    count(result) = 4
}

test_shoul_have_fetch_modidied_resources {
    result = num_modifies with input as data.fixtures.base
    # print(count(result))
    count(result) = 4
}

test_allow_auto_merge {
	allow with input as data.fixtures.base
}
