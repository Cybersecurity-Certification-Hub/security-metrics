package cch.metrics.transport_encryption_signature_algorithm

import data.cch.compare
import rego.v1
import input.transportEncryption as enc

default applicable = false

default compliant = false

applicable if {
    enc
}

compliant if {
    compare(data.operator, data.target_value, enc.tlsSignatureAlgorithm)
}