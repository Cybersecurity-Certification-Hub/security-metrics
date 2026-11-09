package cch.metrics.admin_mfa_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input as identity
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enforceMfa" in object.keys(identity)
	"Identity" in identity.type

	# we are only interested in some kind of privileged user
	identity.privileged
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("enforceMfa", identity.enforceMfa)]
