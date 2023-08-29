package main
import future.keywords  # this is a special import to enable some newer keywords
import data.policy.role  # import the role package

allow_review := true if {  # allow a customer with reputation >= 0 to review
  # EXERCISE 1:
  # - Click the "Validate" button on the top-right corner.
  # - See in the bottom "Tests" pane two tests are failing.
  # - The "test_disallow_non_customer_to_review" test fails because the current policy allows a non-customer to review.
  # - Fix the failure by uncommenting line 11 below. Click "Validate" again to see that only one test fails.
  input.role == "customer"
  input.reputation >= 0
}

is_moderator := true if {  # anyone with reputation at least 100 is a moderator
  input.reputation >= 100
}

is_moderator := true if {  # anyone with "admin" role is a moderator
  # EXERCISE 2:
  # - The test "test_allow_admin_to_delete" is failing because the current policy does
  #   not consider an admin a moderator.
  # - Replace the next line (24) with the correct condition so that all tests pass.
  # false
  input.role == "admin"
}

allow_delete := true if {  # allow a moderator to delete
  is_moderator == true
}

# EXERCISE 3:
# - Replace line 28 above with role.is_moderator == true to use the
#   is_moderator value defined in the policy.role package.
# - Delete lines 15-25 which are no longer necessary.
# - Click "Validate" again to confirm that all tests continue to pass.
