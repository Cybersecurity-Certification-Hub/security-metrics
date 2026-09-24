package cch.metrics.at_rest_encryption_algorithm

import data.cch.comparison_result
import rego.v1

import input.atRestEncryption as enc

default applicable = false

default compliant = false

applicable if {
	enc
}

compliant if {
	some r in results
	r.success
}

results := [comparison_result("atRestEncryption.algorithm", e.algorithm) | e := enc[_]]
