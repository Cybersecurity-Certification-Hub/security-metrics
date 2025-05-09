package cch.metrics.anomaly_detection_output

import data.cch.compare
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
