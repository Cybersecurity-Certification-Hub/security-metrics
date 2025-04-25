package cch.metrics.at_rest_encryption_enabled

import data.cch.compare

import input.atRestEncryption as enc

default applicable = false

default compliant = false

applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc[_].enabled)
}
