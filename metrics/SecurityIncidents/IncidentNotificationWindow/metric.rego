package cch.metrics.incident_notification_window

import data.cch.all_compliant
import data.cch.comparison_result
import input.securityIncident as securityIncident
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"notificationWindowHours" in object.keys(securityIncident)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The procedure states a maximum notification window within the required limit." if {
	compliant
} else := "The procedure does not state a maximum notification window within the required limit." if {
	not compliant
}

results := [comparison_result("securityIncident.notificationWindowHours", securityIncident.notificationWindowHours)]
