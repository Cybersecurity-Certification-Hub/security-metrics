package cch.metrics.data_confidentiality_sdn_policy_presence

import data.cch.all_compliant
import data.cch.comparison_result
import input.dataConfidentialitySdnPolicy as dataConfidentialitySDNPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"isDefined" in object.keys(input.dataConfidentialitySdnPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines a data confidentiality policy for SDN." if {
	compliant
} else := "The policy document does not define a data confidentiality policy for SDN." if {
	not compliant
}

results := [comparison_result("dataConfidentialitySDNPolicy.isDefined", dataConfidentialitySDNPolicy.isDefined)]
