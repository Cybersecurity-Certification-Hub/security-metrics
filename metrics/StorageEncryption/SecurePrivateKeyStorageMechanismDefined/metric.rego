package cch.metrics.secure_private_key_storage_mechanism_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.keyManagementPolicy != {}
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.keyManagementPolicy.isDefined)
}

message := "The policy document defines a secure mechanism for storing private keys." if {
	compliant
} else := "The policy document does not define a secure mechanism for storing private keys." if {
	not compliant
}
