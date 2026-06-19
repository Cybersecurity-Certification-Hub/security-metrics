package cch.metrics.incident_reporting_team

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.securityIncident
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.securityIncident.team)
}

message := "The policy document defines an incident reporting team." if {
	compliant
} else := "The policy document does not define an incident reporting team." if {
	not compliant
}
