package cch.metrics.at_rest_encryption_enabled

import data.cch.comparison_result
import rego.v1

import input.atRestEncryption as enc

default applicable = false

default compliant = false

applicable if {
	"Storage" in input.type
	some k
	e := enc[k]
	"enabled" in object.keys(e)
}

compliant if {
	some r in results
	r.success
}

results := [comparison_result(sprintf("atRestEncryption.%s.enabled", [k]), e.enabled) | some k; e := enc[k]]
