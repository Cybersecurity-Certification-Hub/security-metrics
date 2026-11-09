package cch.metrics.l_3_firewall_restricted_ports

import data.cch.all_compliant
import data.cch.comparison_result
import input.accessRestriction.l3Firewall as l3
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"restrictedPorts" in object.keys(l3)
	input.type[_] == "NetworkInterface"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("accessRestriction.l3Firewall.restrictedPorts", l3.restrictedPorts)]
