package cch.metrics.security_training_cadence

import data.cch.comparison_result
import rego.v1
import input.awarenessTraining as awarenessTraining

default applicable := false
default compliant := false

applicable if {
	"annualCadenceStated" in object.keys(awarenessTraining)
	is_boolean(awarenessTraining.annualCadenceStated)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The training plan is delivered at least annually to all employees." if {
	compliant
} else := "The training plan does not state it is delivered at least annually to all employees." if {
	not compliant
}

results := [comparison_result("awarenessTraining.annualCadenceStated", awarenessTraining.annualCadenceStated)]
