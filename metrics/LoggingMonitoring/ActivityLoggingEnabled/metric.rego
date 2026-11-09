package cch.metrics.activity_logging_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.activityLogging as al
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enabled" in object.keys(input.activityLogging)
}

compliant if {
	all_compliant(results)
}

message := "Activity logging settings are properly defined." if {
	compliant
} else := "Activity logging settings are not properly defined. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("activityLogging.enabled", al.enabled),
]
