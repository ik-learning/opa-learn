<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Exercise 0](#exercise-0)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Exercise 0

Bucket check created or deleted

`mk tests num=1`

```sh
data.terraform.test_empty_allowed: PASS (401.857µs)
data.terraform.test_new_tenant_allowed: PASS (1.817564ms)
data.terraform.test_no_changes_allowed: PASS (2.765902ms)
data.terraform.test_s3_delete_denied: PASS (3.267142ms)
data.terraform.test_kms_delete_denied: PASS (3.366138ms)
--------------------------------------------------------------------------------
PASS: 5/5
```
