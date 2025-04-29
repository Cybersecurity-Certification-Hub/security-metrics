package cch.metrics.transport_encryption_protocol_version

import data.cch.compare
import rego.v1
import input.transportEncryption as enc

default compliant = false

default applicable = false

applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc.protocolVersion)
}
