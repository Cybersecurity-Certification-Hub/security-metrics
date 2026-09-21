package cch.metrics.boot_logging_retention

import data.cch.comparison_result
import rego.v1
import input.bootLogging as logging

default applicable = false

default compliant = false

applicable if {
	logging
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("bootLogging.retentionPeriod.days", time.parse_duration_ns(logging.retentionPeriod) / (((1000 * 1000) * 1000) * 3600))]
