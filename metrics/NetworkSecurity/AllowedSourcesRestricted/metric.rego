package cch.metrics.allowed_sources_restricted

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.accessRestriction.l3Firewall as l3

default applicable = false

default compliant = false

applicable if {
	l3.allowedSources
    # the resource type should be an Network Interface
	input.type[_] == "NetworkInterface"
}

compliant if {
	compare(data.operator, data.target_value, l3.allowedSources)
}

results := [comparison_result("accessRestriction.l3Firewall.allowedSources", l3.allowedSources)]
