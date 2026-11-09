package cch.metrics.anomaly_detection_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.anomalyDetection as ad
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enabled" in object.keys(input.anomalyDetection)
}

compliant if {
	all_compliant(results)
}

message := "Anomaly detection settings are properly defined." if {
	compliant
} else := "Anomaly detection settings are not properly defined. The enabled value should match the specified value." if {
	not compliant
}

results := [
	comparison_result("anomalyDetection.enabled", ad.enabled),
]
