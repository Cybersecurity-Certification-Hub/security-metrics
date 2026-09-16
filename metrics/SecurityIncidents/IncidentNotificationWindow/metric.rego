package cch.metrics.incident_notification_window

import data.cch.comparison_result
import rego.v1
import input.incidentManagement as incidentManagement

default applicable := false
default compliant := false

applicable if {
      incidentManagement != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("incidentManagement.notificationWindowHours", incidentManagement.notificationWindowHours)]
