package cch.metrics.boot_logging_enabled

import data.cch.comparison_result
import rego.v1
import input.bootLogging as logging

default applicable := false
default compliant := false

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

message := "Boot logging is properly configured." if {
	compliant
} else := "Boot logging is not properly configured. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("bootLogging.enabled", logging.enabled),
] 