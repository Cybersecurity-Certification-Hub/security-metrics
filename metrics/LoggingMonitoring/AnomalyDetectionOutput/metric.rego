package cch.metrics.anomaly_detection_output

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.anomalyDetection.applicationLogging as logging

default applicable = false

default compliant = false

applicable if {
	logging 
}

compliant if {
	compare(data.operator, data.target_value, count(logging.loggingServiceIds))
}

results := [comparison_result("anomalyDetection.applicationLogging.loggingServiceIds.count", count(logging.loggingServiceIds))]
