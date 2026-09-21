package cch.metrics.incident_reporting_contact_stated

import data.cch.comparison_result
import rego.v1
import input.securityIncident as securityIncident

default applicable := false
default compliant := false

applicable if {
	"team" in object.keys(securityIncident)
	is_boolean(securityIncident.team)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document states a contact for incident reporting." if {
	compliant
} else := "The policy document does not state a contact for incident reporting." if {
	not compliant
}

results := [comparison_result("securityIncident.team", securityIncident.team)]
