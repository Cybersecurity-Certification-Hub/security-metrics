package cch.metrics.transport_encryption_enabled

import data.cch.compare

import input.transportEncryption as enc

default applicable = false

default compliant = false

applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc[_].enforced)
}
