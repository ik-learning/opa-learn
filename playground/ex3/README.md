<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Exercise 3](#exercise-3)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Exercise 3

> Run auth example

```sh
mk tests num=3

data.authz.test_post_allowed: PASS (357.678µs)
data.authz.test_get_denied: PASS (123.365µs)
data.authz.test_get_user_allowed: PASS (192.249µs)
data.authz.test_get_another_user_denied: PASS (156.752µs)
data.authz.todo_test_user_allowed_http_client_data: SKIPPED
--------------------------------------------------------------------------------
PASS: 4/5
SKIPPED: 1/5
make: *** [tests] Error 2
```
