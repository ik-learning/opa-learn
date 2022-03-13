<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

- [Exercise 0](#exercise-0)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Exercise 0

Example from [here](https://www.openpolicyagent.org/docs/latest/terraform/).

> Terraform blask radius tests

```sh
opa exec --decision terraform/analysis/authz --bundle playground/ex4/ playground/ex4/fixtures/default/apply.json
opa exec --decision terraform/analysis/score --bundle playground/ex4/ playground/ex4/fixtures/default/apply.json
```
