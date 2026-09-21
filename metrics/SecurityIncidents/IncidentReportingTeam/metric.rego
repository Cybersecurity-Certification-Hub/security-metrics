package cch.metrics.incident_reporting_team

import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.securityIncident != {}
	"PolicyDocument" in document.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines an incident reporting team." if {
	compliant
} else := "The policy document does not define an incident reporting team." if {
	not compliant
}

results := [comparison_result("securityIncident.team", document.securityIncident.team)]
