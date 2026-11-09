package cch.metrics.security_training_plan_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.awarenessTraining as awarenessTraining
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"planDocumented" in object.keys(awarenessTraining)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The organization maintains a documented cybersecurity training and awareness plan." if {
	compliant
} else := "The organization does not maintain a documented cybersecurity training and awareness plan." if {
	not compliant
}

results := [comparison_result("awarenessTraining.planDocumented", awarenessTraining.planDocumented)]
