package cch.metrics.security_training_plan_documented

import data.cch.comparison_result
import rego.v1
import input.awarenessTraining as awarenessTraining

default applicable := false
default compliant := false

applicable if {
	"planDocumented" in object.keys(awarenessTraining)
	is_boolean(awarenessTraining.planDocumented)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The organization maintains a documented cybersecurity training and awareness plan." if {
	compliant
} else := "The organization does not maintain a documented cybersecurity training and awareness plan." if {
	not compliant
}

results := [comparison_result("awarenessTraining.planDocumented", awarenessTraining.planDocumented)]
