package cch.metrics.strong_cryptographic_hash

import data.cch.compare
import rego.v1
import input.cryptographicHash as ch

default applicable = false

default compliant = false

applicable if {
	# only applicable if the property is given
	ch
}

compliant if {
	compare(data.operator, data.target_value, ch.algorithm)
}
