package app.rbac

# This test will pass.
test_ok {
    true
}

test_empty_allowed {
	apply with input as {}
}

test_empty_allowed {
	apply with input as {}
}

test_alice_access_allowed {
	apply with input as data.fixtures.alice
}

# This test will fail.
test_failure {
    1 == 1
}

# This test will error.
test_error {
    1 / 0
}
