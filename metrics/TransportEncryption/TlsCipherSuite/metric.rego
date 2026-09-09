package cch.metrics.tls_cipher_suite

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.transportEncryption as enc

default applicable = false

default compliant = false

applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc.cipherSuite)
}

results := [comparison_result("transportEncryption.cipherSuite", enc.cipherSuite)]
