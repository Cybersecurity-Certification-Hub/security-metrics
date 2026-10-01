package cch.metrics.password_length

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

amp := input.accountManagementPolicy

applicable if {
	"valid" in object.keys(input.accountManagementPolicy)
}

compliant if {
	# length is in characters
	compare(data.operator, data.target_value, amp.valid)
}
