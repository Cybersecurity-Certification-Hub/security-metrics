package cch.metrics.boot_logging_enabled

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
	compare(data.operator, data.target_value, logging.enabled)
}

results := [comparison_result("bootLogging.enabled", logging.enabled)]
