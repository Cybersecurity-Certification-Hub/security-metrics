package cch.metrics.tls_cipher_suite

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

applicable if {
	some enc in transport_encryptions
	is_array(enc.cipherSuite)
}

compliant if {
	# Prevents an empty results array from being considered compliant.
	count(results) > 0

	# Every generated comparison result must be successful.
	every result in results {
		result.success
	}
}

# Creates one comparison result for every discovered cipherSuite array.
results := [
	comparison_result("transportEncryption.cipherSuite", enc.cipherSuite) |
	some enc in transport_encryptions
	is_array(enc.cipherSuite)
]