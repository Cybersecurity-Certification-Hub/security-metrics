package cch.metrics.need_to_know_policy_presence

import data.cch.all_compliant
import data.cch.comparison_result
import input.needToKnowPolicy as needToKnowPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"isDefined" in object.keys(input.needToKnowPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines a need-to-know policy." if {
	compliant
} else := "The policy document does not define a need-to-know policy." if {
	not compliant
}

results := [comparison_result("needToKnowPolicy.isDefined", needToKnowPolicy.isDefined)]
