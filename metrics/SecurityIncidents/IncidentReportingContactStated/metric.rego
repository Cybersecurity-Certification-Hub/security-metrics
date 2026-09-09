package cch.metrics.incident_reporting_contact_stated

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.securityIncident
}

compliant if {
	compare(data.operator, data.target_value, document.securityIncident.reportingContactStated)
}
