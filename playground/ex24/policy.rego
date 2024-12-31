package play

import rego.v1
# https://docs.styra.com/opa/rego-by-example/keywords/some
example_array := [1, "example", 3]

filtered_array := [e |
	some e in example_array

	is_number(e)
]
