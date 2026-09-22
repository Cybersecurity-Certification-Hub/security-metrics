package cch.metrics.anomaly_detection_output

import data.cch.comparison_result
import rego.v1
import input.anomalyDetection.applicationLogging as logging

default applicable := false
default compliant := false

# The metric is applicable when loggingServiceIds is configured as an array.
applicable if {
	is_array(logging.loggingServiceIds)
	"DatabaseService" in input.type
}

compliant if {
	every r in results {
		r.success
	}
}

message := "Anomaly detection output settings are properly defined." if {
	compliant
} else := "Anomaly detection output settings are not properly defined. The number of logging service IDs should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"anomalyDetection.applicationLogging.loggingServiceIds.count",
		count(logging.loggingServiceIds),
	),
]