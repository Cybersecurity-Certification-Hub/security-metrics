package cch.metrics.identity_password_policy_enabled

import data.cch.comparison_result
import rego.v1
import input as identity

default applicable = false

default compliant = false

applicable if {
	# the resource type should be an Identity
	identity.type[_] == "Identity"
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("disablePasswordPolicy", identity.disablePasswordPolicy)]
