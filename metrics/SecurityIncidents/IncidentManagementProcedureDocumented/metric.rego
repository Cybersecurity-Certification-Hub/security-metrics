package cch.metrics.incident_management_procedure_documented

import data.cch.comparison_result
import rego.v1
import input.securityIncident as securityIncident

default applicable := false
default compliant := false

applicable if {
	"registryAndSlaStated" in object.keys(securityIncident)
	is_boolean(securityIncident.registryAndSlaStated)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The organization has an incident management procedure with an incident registry and handling SLA reference." if {
	compliant
} else := "The organization does not have an incident management procedure with an incident registry and handling SLA reference." if {
	not compliant
}

results := [comparison_result("securityIncident.registryAndSlaStated", securityIncident.registryAndSlaStated)]
