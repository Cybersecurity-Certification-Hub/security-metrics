package cch.metrics.os_logging_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.osLogging as logging
import rego.v1

default applicable := false

default compliant := false

# The metric is applicable when enabled is present and boolean.
applicable if {
	"enabled" in object.keys(logging)
	"VirtualMachine" in input.type
}

compliant if {
	all_compliant(results)
}

message := "OS logging is properly configured." if {
	compliant
} else := "OS logging is not properly configured. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("osLogging.enabled", logging.enabled),
]
