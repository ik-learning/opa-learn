package example

# This test will pass.
test_ok {
    true
}

# This test will fail.
test_failure {
    1 == 2
}

# This test will error.
test_error {
    1 / 0
}
