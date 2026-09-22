package cch.metrics.os_logging_output

import data.cch.comparison_result
import rego.v1
import input.osLogging as logging

default applicable := false
default compliant := false

# The metric is applicable when loggingServiceIds is present and an array.
applicable if {
	"loggingServiceIds" in object.keys(logging)
	is_array(logging.loggingServiceIds)
	"VirtualMachine" in input.type
}

compliant if {
	every r in results {
		r.success
	}
}

message := "OS logging output is properly configured." if {
	compliant
} else := "OS logging output is not properly configured. The number of logging service IDs should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"osLogging.loggingServiceIds.count",
		count(logging.loggingServiceIds),
	),
] 