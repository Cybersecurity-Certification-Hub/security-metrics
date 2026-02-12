package cch.metrics.transportEncryptionUnsupportedMechanisms

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    # TODO: Add ontology term
    compare(data.operator, data.target_value, document.transportEncryption.unsupportedMechanisms)
}
