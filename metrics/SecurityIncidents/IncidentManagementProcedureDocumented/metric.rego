package cch.metrics.incident_management_procedure_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.securityIncident as securityIncident
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"handlingPeriodHours" in object.keys(securityIncident)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The organization has an incident management procedure with an incident registry and handling SLA reference." if {
	compliant
} else := "The organization does not have an incident management procedure with an incident registry and handling SLA reference." if {
	not compliant
}

results := [comparison_result("securityIncident.handlingPeriodHours", securityIncident.handlingPeriodHours)]
