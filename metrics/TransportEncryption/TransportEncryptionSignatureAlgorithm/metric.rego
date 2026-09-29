package cch.metrics.transport_encryption_signature_algorithm

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

# The metric is applicable when at least one tlsSignatureAlgorithm value exists.
applicable if {
	some enc in transport_encryptions
	signature_algorithm := object.get(enc, "tlsSignatureAlgorithm", null)
	is_string(signature_algorithm)
}

# Creates one comparison result for every discovered tlsSignatureAlgorithm value.
results := [
	comparison_result("transportEncryption.tlsSignatureAlgorithm", signature_algorithm) |
	some enc in transport_encryptions
	signature_algorithm := object.get(enc, "tlsSignatureAlgorithm", null)
	is_string(signature_algorithm)
]

compliant if {
	applicable
	count(results) > 0

	# All discovered tlsSignatureAlgorithm values must satisfy the comparison.
	every result in results {
		result.success
	}
}