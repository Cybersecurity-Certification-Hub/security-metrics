package cch.metrics.boot_logging_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.bootLogging as logging
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enabled" in object.keys(logging)
	"VirtualMachine" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Boot logging is properly configured." if {
	compliant
} else := "Boot logging is not properly configured. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("bootLogging.enabled", logging.enabled),
]
