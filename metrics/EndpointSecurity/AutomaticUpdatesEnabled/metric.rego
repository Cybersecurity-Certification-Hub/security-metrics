package cch.metrics.automatic_updates_enabled

import data.cch.compare
import data.cch.comparison_result
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

results := [comparison_result("automaticUpdates.enabled", au.enabled)]
