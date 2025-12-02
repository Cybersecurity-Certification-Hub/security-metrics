package cch.metrics.incident_management_policy01

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
  document
}

compliant if {
  document:SecurityIncident.Team in data.target_value
}

message := "The document has set the incident management team." if {
	compliant
} else := "The document has not set a valid incident management team." if {
	not compliant
}
