package cch.metrics.l_3_firewall_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.accessRestriction.l3Firewall as l3
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enabled" in object.keys(l3)

	# the resource type should be an Network Interface
	input.type[_] == "NetworkInterface"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("accessRestriction.l3Firewall.enabled", l3.enabled)]
