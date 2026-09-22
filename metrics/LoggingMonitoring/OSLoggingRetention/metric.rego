package cch.metrics.os_logging_retention

import data.cch.comparison_result
import rego.v1
import input.osLogging as logging

default applicable := false
default compliant := false

# The metric is applicable when retentionPeriod is present.
applicable if {
	"retentionPeriod" in object.keys(logging)
	"VirtualMachine" in input.type
}

# Converts a valid duration value from nanoseconds to days.
retention_period_days := duration_ns / (1000 * 1000 * 1000 * 60 * 60 * 24) if {
	is_string(logging.retentionPeriod)
	duration_ns := time.parse_duration_ns(logging.retentionPeriod)
}

compliant if {
	# Prevents an invalid retention period from being compliant
	# when no comparison result can be created.
	count(results) > 0

	every r in results {
		r.success
	}
}

message := "OS logging retention is properly configured." if {
	compliant
} else := "OS logging retention is not properly configured. The retention period in days should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"osLogging.retentionPeriod.days",
		days,
	),
] 