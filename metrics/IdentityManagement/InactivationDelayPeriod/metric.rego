package cch.metrics.inactivation_delay_period

import data.cch.all_compliant
import data.cch.comparison_result
import input.accountManagementPolicy as accountManagementPolicy
import rego.v1

default applicable := false

default compliant := false

amp := input.accountManagementPolicy

applicable if {
	"intervalMonths" in object.keys(input.accountManagementPolicy)
	input.type[_] == "PolicyDocument"
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines the validity of accounts after inactivity. It ensures that the length is set to a sensible minimum value of months." if {
	compliant
} else := "The policy document does not define the validity of accounts after inactivity. " if {
	not compliant
}

results := [comparison_result("accountManagementPolicy.intervalMonths", accountManagementPolicy.intervalMonths)]
