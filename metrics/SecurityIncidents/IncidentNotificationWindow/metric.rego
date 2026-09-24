package cch.metrics.incident_notification_window

import data.cch.comparison_result
import rego.v1
import input.securityIncident as securityIncident

default applicable := false
default compliant := false

applicable if {
	"notificationWindowHours" in object.keys(securityIncident)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The procedure states a maximum notification window within the required limit." if {
	compliant
} else := "The procedure does not state a maximum notification window within the required limit." if {
	not compliant
}

results := [comparison_result("securityIncident.notificationWindowHours", securityIncident.notificationWindowHours)]
