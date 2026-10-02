package cch.metrics.inactivation_delay_period

import data.cch.comparison_result
import rego.v1
import input.accountManagementPolicy as accountManagementPolicy

default applicable := false

default compliant := false

amp := input.accountManagementPolicy

applicable if {
	"intervalMonths" in object.keys(input.accountManagementPolicy)
	input.type[_] == "PolicyDocument"
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines the validity of accounts after inactivity. It ensures that the length is set to a sensible minimum value of months." if {
	compliant
} else := "The policy document does not define the validity of accounts after inactivity. " if {
	not compliant
}

results := [comparison_result("accountManagementPolicy.intervalMonths", accountManagementPolicy.intervalMonths)]
