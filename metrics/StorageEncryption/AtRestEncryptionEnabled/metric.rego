package cch.metrics.at_rest_encryption_enabled

import data.cch.comparison_result
import rego.v1

import input.atRestEncryption as enc

default applicable = false
default compliant = false

applicable if {
	"Storage" in input.type
	e := enc[_]
	"enabled" in object.keys(e)
}

compliant if {
	some r in results
	r.success
}

results := [comparison_result("atRestEncryption.enabled", e.enabled) | e := enc[_]]
