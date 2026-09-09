package cch.metrics.rate_limiting_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.accessRestriction.rateLimiting as rl

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "LoadBalancer"
	rl
}

compliant if {
	compare(data.operator, data.target_value, rl.enabled)
}

results := [comparison_result("accessRestriction.rateLimiting.enabled", rl.enabled)]
