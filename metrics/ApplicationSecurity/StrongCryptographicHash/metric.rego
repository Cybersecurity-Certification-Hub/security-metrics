package cch.metrics.strong_cryptographic_hash

import data.cch.all_compliant
import data.cch.comparison_result
import input.cryptographicHash as ch
import rego.v1

default applicable := false

default compliant := false

applicable if {
	# only applicable if the property is given
	"algorithm" in object.keys(ch)
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("cryptographicHash.algorithm", ch.algorithm)]
