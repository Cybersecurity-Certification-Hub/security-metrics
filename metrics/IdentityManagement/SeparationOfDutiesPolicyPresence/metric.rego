package cch.metrics.separation_of_duties_policy_presence

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.separationOfDutiesPolicy as separationOfDutiesPolicy

default applicable := false
default compliant := false

applicable if {
	separationOfDutiesPolicy != {}
	"PolicyDocument" in input.type
}

compliant if {
	compare(data.operator, data.target_value, separationOfDutiesPolicy.isDefined)
}

message := "The policy document defines a separation of duties policy." if {
	compliant
} else := "The policy document does not define a separation of duties policy." if {
	not compliant
}

results := [comparison_result("separationOfDutiesPolicy.isDefined", separationOfDutiesPolicy.isDefined)]
