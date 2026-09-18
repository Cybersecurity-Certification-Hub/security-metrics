package cch.metrics.data_confidentiality_sdn_policy_presence

import data.cch.comparison_result
import rego.v1
import input.dataConfidentialitySDNPolicy as dataConfidentialitySDNPolicy

default applicable := false
default compliant := false

applicable if {
	"isDefined" in object.keys(input.dataConfidentialitySDNPolicy)
	"PolicyDocument" in input.type
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
