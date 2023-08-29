package a__rules.ex1
import future.keywords

# METADATA
# scope: document
# description: A set of rules that determines if x is allowed.

# Exercises with AND and OR
# To begin this exercise module, uncomment the following line to enable test cases.
# _test_enabled := true
# Then continue to the exercises below.

# Exercise 1
# Write rule(s) to make output1 true exactly when all of the following is true
#   input.a
#   input.b
#   input.c
# Sample input/output:
# Input: {"a": true, "b": true, "c": true}
# Output: {"output1": true, ...}
output1 := true if {
  false  # TODO
}

# Exercise 2
# Write rule(s) to make output2 true exactly when at least one of the following is true
#   input.a
#   input.b
#   input.c
# Sample input/output:
# Input: {"a": false, "b": false, "c": true}
# Output: {"output2": true, ...}
output2 := true if {
  false  # TODO
}

# Exercise 3
# Write rule(s) to make output3 true exactly when both of the following is true
#   input.a
#   at leats one of input.b and input.c is true
# Sample input/output:
# Input: {"a": true, "b": false, "c": true}
# Output: {"output3": true, ...}
output3 := true if {
  false  # TODO
}
