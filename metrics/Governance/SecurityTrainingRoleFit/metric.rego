package cch.metrics.security_training_role_fit

import data.cch.comparison_result
import rego.v1
import input.awarenessTraining as awarenessTraining

default applicable := false
default compliant := false

applicable if {
	"roleAdjustedTracksStated" in object.keys(awarenessTraining)
	is_boolean(awarenessTraining.roleAdjustedTracksStated)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The training plan includes role-based tracks adjusted by employee function." if {
	compliant
} else := "The training plan does not include role-based tracks adjusted by employee function." if {
	not compliant
}

results := [comparison_result("awarenessTraining.roleAdjustedTracksStated", awarenessTraining.roleAdjustedTracksStated)]
