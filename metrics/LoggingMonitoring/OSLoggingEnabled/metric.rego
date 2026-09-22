package cch.metrics.os_logging_enabled

import data.cch.comparison_result
import rego.v1
import input.osLogging as logging

default applicable := false
default compliant := false

# The metric is applicable when enabled is present and boolean.
applicable if {
	"enabled" in object.keys(logging)
	is_boolean(logging.enabled)
	"VirtualMachine" in input.type
}

compliant if {
	every r in results {
		r.success
	}
}

message := "OS logging is properly configured." if {
	compliant
} else := "OS logging is not properly configured. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("osLogging.enabled", logging.enabled),
] if {
	applicable
}