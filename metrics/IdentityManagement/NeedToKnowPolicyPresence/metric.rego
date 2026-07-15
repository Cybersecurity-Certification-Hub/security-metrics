package cch.metrics.need_to_know_policy_presence

import data.cch.compare
import rego.v1
import input.needToKnowPolicy as needToKnowPolicy

default applicable := false
default compliant := false

applicable if {
	needToKnowPolicy != {}
	"PolicyDocument" in input.type
}

compliant if {
	compare(data.operator, data.target_value, needToKnowPolicy.isDefined)
}

message := "The policy document defines a need-to-know policy." if {
	compliant
} else := "The policy document does not define a need-to-know policy." if {
	not compliant
}
