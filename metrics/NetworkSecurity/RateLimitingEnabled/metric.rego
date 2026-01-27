package cch.metrics.rate_limiting_enabled

import data.cch.compare
import rego.v1

import input.rate_limiting as rl

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "LoadBalancer"
	rl
}

compliant if {
	compare(data.operator, data.target_value, rl.enabled)
}
