package cch.metrics.transport_encryption_protocol_version

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

# The metric is applicable when at least one protocolVersion value exists.
applicable if {
	some enc in transport_encryptions
	protocol_version := object.get(enc, "protocolVersion", null)
	is_string(protocol_version)
}

# Creates one comparison result for every discovered protocolVersion value.
results := [
	comparison_result("transportEncryption.protocolVersion", protocol_version) |
	some enc in transport_encryptions
	protocol_version := object.get(enc, "protocolVersion", null)
	is_string(protocol_version)
]

compliant if {
	applicable
	count(results) > 0

	# All discovered protocolVersion values must satisfy the comparison.
	every result in results {
		result.success
	}
}