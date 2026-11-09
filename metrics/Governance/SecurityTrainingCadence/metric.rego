package cch.metrics.security_training_cadence

import data.cch.all_compliant
import data.cch.comparison_result
import input.awarenessTraining as awarenessTraining
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"annualCadenceStated" in object.keys(awarenessTraining)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The training plan is delivered at least annually to all employees." if {
	compliant
} else := "The training plan does not state it is delivered at least annually to all employees." if {
	not compliant
}

results := [comparison_result("awarenessTraining.annualCadenceStated", awarenessTraining.annualCadenceStated)]
