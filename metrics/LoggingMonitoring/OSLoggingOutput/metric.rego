package cch.metrics.os_logging_output

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.osLogging as logging

default applicable = false

default compliant = false

applicable if {
	logging
}

compliant if {
	compare(data.operator, data.target_value, count(logging.loggingServiceIds))
}

results := [comparison_result("osLogging.loggingServiceIds.count", count(logging.loggingServiceIds))]
