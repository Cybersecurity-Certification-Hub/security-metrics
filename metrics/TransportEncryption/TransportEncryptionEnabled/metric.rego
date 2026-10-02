package cch.metrics.transport_encryption_enabled

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

# The metric is applicable when at least one boolean enabled value exists.
applicable if {
	some enc in transport_encryptions
	enabled := object.get(enc, "enabled", null)
	is_boolean(enabled)
}

# Creates one comparison result for every discovered enabled value.
results := [
	comparison_result("transportEncryption.enabled", enabled) |
	some enc in transport_encryptions
	enabled := object.get(enc, "enabled", null)
	is_boolean(enabled)
]

compliant if {
	applicable
	count(results) > 0

	# All discovered enabled values must satisfy the comparison.
	every result in results {
		result.success
	}
}