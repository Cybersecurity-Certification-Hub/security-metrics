package cch.metrics.admin_mfa_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input as identity

default applicable = false

default compliant = false

applicable if {
	"Identity" in identity.type

	# we are only interested in some kind of privileged user
	identity.privileged
}

compliant if {
	compare(data.operator, data.target_value, identity.enforceMfa)
}

results := [comparison_result("enforceMfa", identity.enforceMfa)]
