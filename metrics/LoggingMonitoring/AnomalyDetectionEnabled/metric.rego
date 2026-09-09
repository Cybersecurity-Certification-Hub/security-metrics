package cch.metrics.anomaly_detection_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

enabled := input.anomalyDetection.enabled

applicable if {
	enabled != null
}

compliant if {
	compare(data.operator, data.target_value, enabled)
}

results := [comparison_result("anomalyDetection.enabled", enabled)]
