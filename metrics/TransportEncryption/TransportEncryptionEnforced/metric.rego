package cch.metrics.transport_encryption_enforced

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Finds transportEncryption directly under input or at any nesting level.
transport_encryptions contains enc if {
	walk(input, [path, enc])
	count(path) > 0
	path[count(path) - 1] == "transportEncryption"
	is_object(enc)
}

# The metric is applicable when at least one boolean enforced value exists.
applicable if {
	some enc in transport_encryptions
	enforced := object.get(enc, "enforced", null)
	is_boolean(enforced)
}

# Creates one comparison result for every discovered enforced value.
results := [
	comparison_result("transportEncryption.enforced", enforced) |
	some enc in transport_encryptions
	enforced := object.get(enc, "enforced", null)
	is_boolean(enforced)
]

compliant if {
	applicable
	count(results) > 0

	# All discovered enforced values must satisfy the comparison.
	every result in results {
		result.success
	}
}