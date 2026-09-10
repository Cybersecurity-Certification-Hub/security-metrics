package cch.metrics.transport_encryption_protocol

import data.cch.comparison_result
import rego.v1
import input.transportEncryption as enc

default compliant = false

default applicable = false

applicable if {
	enc
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("transportEncryption.protocol", enc.protocol)]
