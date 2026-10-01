package cch.metrics.automatic_updates_enabled

import data.cch.compare
import rego.v1

import input.automaticUpdates as au

default applicable = false

default compliant = false

applicable if {
	au
	"VirtualMachine" in input.type
}

compliant if {
	compare(data.operator, data.target_value, au.enabled)
}
