package metrics.logging_monitoring.anomaly_detection_enabled

import data.compare
import rego.v1

default applicable = false

default compliant = false

enabled := input.anomalyDetection.enabled

applicable {
	enabled != null
}

compliant {
	compare(data.operator, data.target_value, enabled)
}
