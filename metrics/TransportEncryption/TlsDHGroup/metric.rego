package cch.metrics.tls_dh_group

import data.cch.comparison_result
import rego.v1
import input.transportEncryption as enc

default applicable = false

default compliant = false

applicable if {
	enc
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("transportEncryption.dhGroup", enc.dhGroup)]
