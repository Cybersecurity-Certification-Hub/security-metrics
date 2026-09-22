package cch.metrics.tls_dh_groups

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Finds transportEncryption directly under input or at any nesting level.Verschachtelungsebene.
transport_encryptions contains enc if {
	walk(input, [path, enc])
	count(path) > 0
	path[count(path) - 1] == "transportEncryption"
	is_object(enc)
}

# Checks if at least one dhGroup element is available
applicable if {
	some enc in transport_encryptions
	dh_groups := object.get(enc, "dhGroups", null)
	dh_groups != null
}

# Erzeugt ein Ergebnis für jede gefundene dhGroups.
results := [
	comparison_result("transportEncryption.dhGroups", dh_groups) |
	some enc in transport_encryptions
	dh_groups := object.get(enc, "dhGroups", null)
	dh_groups != null
]

compliant if {
	applicable
	count(results) > 0

	every result in results {
		result.success
	}
}