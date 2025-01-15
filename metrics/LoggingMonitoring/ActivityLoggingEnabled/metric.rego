package metrics.logging_monitoring.activity_logging_enabled

import data.compare
import rego.v1

default applicable = false

default compliant = false

enabled := input.resourceLogging.enabled

applicable {
	enabled != null
}

compliant {
	compare(data.operator, data.target_value, enabled)
}