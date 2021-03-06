package authz

test_post_allowed {
    allow with input as data.fixtures.post_allowed
}

test_delete_not_allowed {
    not allow with input as data.fixtures.delete_not_allowed
}

test_get_denied {
    not allow with input as {"path": ["users"], "method": "GET"}
}

test_get_user_allowed {
    allow with input as {"path": ["users", "bob"], "method": "GET", "user_id": "bob"}
}

test_get_another_user_denied {
    not allow with input as data.fixtures.get_another_user_denied
}

todo_test_user_allowed_http_client_data {
    false # Remember to test this later!
}
