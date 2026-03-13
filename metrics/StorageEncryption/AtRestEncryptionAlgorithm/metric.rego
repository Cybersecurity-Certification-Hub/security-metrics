package cch.metrics.at_rest_encryption_algorithm

import data.cch.compare
import rego.v1

import input.atRestEncryption as enc

default applicable = false

default compliant = false

# Evidence containing `atRestEncryption` is applicable, e.g. a storage and a policy document
applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc[_].algorithm)
}
