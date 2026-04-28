package cch.metrics.separation_of_duties_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.SeparationOfDutiesPolicy
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.SeparationOfDutiesPolicy.isDefined)
}

message := "The policy document defines a separation of duties policy." if {
	compliant
} else := "The policy document does not define a separation of duties policy." if {
	not compliant
}
