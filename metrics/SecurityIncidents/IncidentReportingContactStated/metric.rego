package cch.metrics.incident_reporting_contact_stated

import data.cch.all_compliant
import data.cch.comparison_result
import input.securityIncident as securityIncident
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"securityIncident" in object.keys(input)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document states a contact for incident reporting." if {
	compliant
} else := "The policy document does not state a contact for incident reporting." if {
	not compliant
}

results := [comparison_result("securityIncident.reportingContacts", object.get(securityIncident, "reportingContacts", []))]
