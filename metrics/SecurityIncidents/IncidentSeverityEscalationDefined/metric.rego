package cch.metrics.incident_severity_escalation_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.incidentManagement
}

compliant if {
	compare(data.operator, data.target_value, document.incidentManagement.severityAndEscalationDefined)
}
