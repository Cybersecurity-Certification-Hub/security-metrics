package cch.metrics.l_3_firewall_restricted_ports

import data.cch.comparison_result
import rego.v1
import input.accessRestriction.l3Firewall as l3

default applicable = false

default compliant = false

applicable if {
	l3
    # the resource type should be an Network Interface
	input.type[_] == "NetworkInterface"
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("accessRestriction.l3Firewall.restrictedPorts", l3.restrictedPorts)]
