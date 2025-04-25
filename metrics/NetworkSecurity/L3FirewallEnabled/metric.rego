package cch.metrics.l_3_firewall_enabled

import data.cch.compare
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
	compare(data.operator, data.target_value, l3.enabled)
}
