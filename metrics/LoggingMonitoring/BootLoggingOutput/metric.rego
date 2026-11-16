package cch.metrics.boot_logging_output

import data.cch.all_compliant
import data.cch.comparison_result
import input.bootLogging as logging
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"loggingServiceIds" in object.keys(logging)
	"VirtualMachine" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Boot logging output is properly configured." if {
	compliant
} else := "Boot logging output is not properly configured. The number of logging service IDs should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"bootLogging.loggingServiceIds.count",
		count(object.get(logging, "loggingServiceIds", [])),
	),
]
