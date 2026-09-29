package cch.metrics.transport_encryption_protocol

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

# The metric is applicable when at least one protocol value exists.
applicable if {
	some enc in transport_encryptions
	protocol := object.get(enc, "protocol", null)
	is_string(protocol)
}

# Creates one comparison result for every discovered protocol value.
results := [
	comparison_result("transportEncryption.protocol", protocol) |
	some enc in transport_encryptions
	protocol := object.get(enc, "protocol", null)
	is_string(protocol)
]

compliant if {
	applicable
	count(results) > 0

	# All discovered protocol values must satisfy the comparison.
	every result in results {
		result.success
	}
}