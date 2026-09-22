package cch.metrics.tls_dh_group

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
	dh_group := object.get(enc, "dhGroup", null)
	dh_group != null
}

# Erzeugt ein Ergebnis für jede gefundene dhGroup.
results := [
	comparison_result("transportEncryption.dhGroup", dh_group) |
	some enc in transport_encryptions
	dh_group := object.get(enc, "dhGroup", null)
	dh_group != null
]

compliant if {
	applicable
	count(results) > 0

	every result in results {
		result.success
	}
}