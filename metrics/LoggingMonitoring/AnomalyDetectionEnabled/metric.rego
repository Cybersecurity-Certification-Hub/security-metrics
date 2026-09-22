package cch.metrics.anomaly_detection_enabled

import data.cch.comparison_result
import rego.v1
import input.anomalyDetection as ad

default applicable := false
default compliant := false

applicable if {
	"enabled" in object.keys(input.anomalyDetection)
}

compliant if {
	every r in results {
		r.success
	}
}

message := "Anomaly detection settings are properly defined." if {
	compliant
} else := "Anomaly detection settings are not properly defined. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("anomalyDetection.enabled", ad.enabled),
] if {
	applicable
}