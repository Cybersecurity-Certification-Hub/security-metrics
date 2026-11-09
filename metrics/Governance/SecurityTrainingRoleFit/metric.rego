package cch.metrics.security_training_role_fit

import data.cch.all_compliant
import data.cch.comparison_result
import input.awarenessTraining as awarenessTraining
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"roleAdjustedTracksStated" in object.keys(awarenessTraining)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The training plan includes role-based tracks adjusted by employee function." if {
	compliant
} else := "The training plan does not include role-based tracks adjusted by employee function." if {
	not compliant
}

results := [comparison_result("awarenessTraining.roleAdjustedTracksStated", awarenessTraining.roleAdjustedTracksStated)]
