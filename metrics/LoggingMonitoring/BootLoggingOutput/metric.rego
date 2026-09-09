package cch.metrics.boot_logging_output

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.bootLogging as logging

default applicable = false

default compliant = false

applicable if {
	logging
}

compliant if {
	compare(data.operator, data.target_value, count(logging.loggingServiceIds))
}

results := [comparison_result("bootLogging.loggingServiceIds.count", count(logging.loggingServiceIds))]
