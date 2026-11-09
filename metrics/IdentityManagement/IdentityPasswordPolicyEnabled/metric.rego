package cch.metrics.identity_password_policy_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input as identity
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"disablePasswordPolicy" in object.keys(identity)

	# the resource type should be an Identity
	identity.type[_] == "Identity"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("disablePasswordPolicy", identity.disablePasswordPolicy)]
