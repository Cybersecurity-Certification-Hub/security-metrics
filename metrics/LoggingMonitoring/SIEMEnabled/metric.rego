package cch.metrics.siem_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

siem := input.securityInformationEventManagement {
	input.securityInformationEventManagement
}

siem := input.loggingService.securityInformationEventManagement {
	input.loggingService.securityInformationEventManagement
}

enabled := siem.enabled

applicable if {
	enabled != null
}

compliant if {
	compare(data.operator, data.target_value, enabled)
}
