package cch.metrics.incident_severity_escalation_defined

import data.cch.comparison_result
import rego.v1
import input.securityIncident as securityIncident

default applicable := false
default compliant := false

applicable if {
	"severityAndEscalationDefined" in object.keys(securityIncident)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "Escalation responsibility for critical and high severity incidents is defined." if {
	compliant
} else := "Escalation responsibility for critical and high severity incidents is not defined." if {
	not compliant
}

results := [comparison_result("securityIncident.severityAndEscalationDefined", securityIncident.severityAndEscalationDefined)]
