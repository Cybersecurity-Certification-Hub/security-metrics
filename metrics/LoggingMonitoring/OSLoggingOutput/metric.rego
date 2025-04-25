package cch.metrics.os_logging_output

import data.cch.compare
import rego.v1
import input.osLogging as logging

default applicable = false

default compliant = false

metricConfiguration := data.target_value

applicable if {
	logging
}

compliant if {
	compare(data.operator, data.target_value, count(logging.loggingServiceIds))
}
