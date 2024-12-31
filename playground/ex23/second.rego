package package2

import rego.v1

import data.package1

output := sprintf("Hello, %v", [package1.name])

# or
import data.package1 as p1

output := sprintf("Hello, %v", [p1.name])
