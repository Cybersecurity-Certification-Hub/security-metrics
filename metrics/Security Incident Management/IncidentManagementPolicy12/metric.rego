package cch.metrics.incident_management_policy12

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:SecurityIncident.Event.userNotificationInterval)
}
