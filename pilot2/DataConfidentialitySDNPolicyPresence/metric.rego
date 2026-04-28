package cch.metrics.data_confidentiality_sdn_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.DataConfidentialitySDNPolicy
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.DataConfidentialitySDNPolicy.isDefined)
}

message := "The policy document defines a data confidentiality policy for SDN." if {
	compliant
} else := "The policy document does not define a data confidentiality policy for SDN." if {
	not compliant
}
