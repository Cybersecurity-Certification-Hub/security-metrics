package cch.metrics.activity_logging_enabled

import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

enabled := input.activityLogging.enabled

applicable if {
	enabled != null
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("activityLogging.enabled", enabled)]
