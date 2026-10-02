package cch.metrics.strong_cryptographic_authentication_mechanisms_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.encryptionPolicy != {}
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.encryptionPolicy.isDefined)
}

message := "The policy document defines strong cryptographic authentication mechanisms." if {
	compliant
} else := "The policy document does not define strong cryptographic authentication mechanisms." if {
	not compliant
}
