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
  compare(data.operator, data.target_value, document:SecurityIncident.Team)
}

message := "The document has set the incident management team." if {
	compliant
} else := "The document has not set a valid incident management team." if {
	not compliant
}
