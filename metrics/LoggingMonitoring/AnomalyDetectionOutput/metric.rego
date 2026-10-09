package cch.metrics.anomaly_detection_output

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# The metric is applicable to database services. Missing logging service IDs count as zero.
applicable if {
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
		count(object.get(input, ["anomalyDetection", "applicationLogging", "loggingServiceIds"], [])),
	),
]