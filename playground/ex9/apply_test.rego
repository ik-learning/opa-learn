package example

# This test will pass.
test_ok {
    true
}

test_should_allow_empty {
	allow with input as {}
}

test_should_have_violations {
	not allow with input as data.fixtures.base
}

test_should_have_no_violations {
	allow with input as data.fixtures.no_violations
}
