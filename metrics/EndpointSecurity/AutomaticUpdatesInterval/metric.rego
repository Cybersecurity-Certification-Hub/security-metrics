package cch.metrics.automatic_updates_interval

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.automaticUpdates as au

default applicable = false

default compliant = false

applicable if {
	"interval" in object.keys(input.automaticUpdates)
	"VirtualMachine" in input.type
}

compliant if {
	# Check if interval is > 0.
	# The discovery should set the interval to 0 if the the automatic update is not enabled. If we do not check 'interval > 0' it can result in 'AutomaticUpdatesEnabled=false' and  'AutomaticUpdatesInterval=true'.
	compare(">", 0, time.parse_duration_ns(au.interval) / (1000000000 * 86400))
	# time.Duration is nanoseconds, we want to convert this to days
	results[0].success
}

results := [comparison_result("automaticUpdates.interval", time.parse_duration_ns(au.interval) / (1000000000 * 86400))]
