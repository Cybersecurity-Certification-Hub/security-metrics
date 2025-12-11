package cch.metrics.web_filtering_enabled

import data.cch.compare
import rego.v1

import input.web_filtering as filtering

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "LoadBalancer"
	filtering
}

compliant if {
	compare(data.operator, data.target_value, filtering.enabled)
}
