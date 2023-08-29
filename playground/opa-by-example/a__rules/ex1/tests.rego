package a__rules.ex1
import future.keywords
import data.__internal.util

# by default, tests are disabled (always pass)
default _test_enabled := true

# METADATA
# title: Allow all true
test_A_0_exercise1_all_true if {
  test_input := {"a": true, "b": true, "c": true}
  util.return_unchanged(output1) == true with input as test_input
} else {
  not _test_enabled
}

test_A_0_exercise1_two_true if {
  test_input := {"a": true, "b": true, "c": false}
  output1 with input as test_input
} else {
  not _test_enabled
}


test_A_0_exercise2_none_true if {
  test_input := {"a": false, "b": false, "c": false}
  not output2 with input as test_input
} else {
  not _test_enabled
}

test_A_0_exercise2_one_true if {
  test_input := {"a": false, "b": false, "c": true}
  util.return_unchanged(output2) == true with input as test_input
} else {
  not _test_enabled
}

test_A_0_exercise3_a_c if {
  test_input := {"a": true, "b": false, "c": true}
  util.return_unchanged(output3) == true with input as test_input
} else {
  not _test_enabled
}

test_A_0_exercise3_b_c if {
  test_input := {"a": false, "b": true, "c": true}
  not output3 with input as test_input
} else {
  not _test_enabled
}

test_A_0_exercise3_a if {
  test_input := {"a": true, "b": false, "c": false}
  not output3 with input as test_input
} else {
  not _test_enabled
}
