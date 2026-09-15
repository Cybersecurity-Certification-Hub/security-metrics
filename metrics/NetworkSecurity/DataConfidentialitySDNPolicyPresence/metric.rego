package cch.metrics.data_confidentiality_sdn_policy_presence

import data.cch.comparison_result
import rego.v1
import input.dataConfidentialitySDNPolicy as dataConfidentialitySDNPolicy

default applicable := false
default compliant := false

applicable if {
	dataConfidentialitySDNPolicy != {}
	"PolicyDocument" in input.type
	dataConfidentialitySDNPolicy.isDefined != {}
	dataConfidentialitySDNPolicy.isDefined != null
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines a data confidentiality policy for SDN." if {
	compliant
} else := "The policy document does not define a data confidentiality policy for SDN." if {
	not compliant
}

results := [comparison_result("dataConfidentialitySDNPolicy.isDefined", dataConfidentialitySDNPolicy.isDefined)]
