package cch.metrics.automatic_updates_enabled

import data.cch.comparison_result
import rego.v1

import input.automaticUpdates as au

default applicable = false

default compliant = false

applicable if {
	au
	"VirtualMachine" in input.type
	au.enabled != {}
	au.enabled != null
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("automaticUpdates.enabled", au.enabled)]
