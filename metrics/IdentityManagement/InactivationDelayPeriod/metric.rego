package cch.metrics.inactivation_delay_period

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

amp := input.accountManagementPolicy

applicable if {
	"intervalMonths" in object.keys(input.accountManagementPolicy)
}

compliant if {
	# length is in characters
	compare(data.operator, data.target_value, amp.intervalMonths)
}
