package cch.metrics.strong_cryptographic_hash

import data.cch.comparison_result
import rego.v1
import input.cryptographicHash as ch

default applicable = false

default compliant = false

applicable if {
	# only applicable if the property is given
	ch
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("cryptographicHash.algorithm", ch.algorithm)]
