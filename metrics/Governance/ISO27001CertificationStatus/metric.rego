package cch.metrics.iso27001_certification_status

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.informationSecurityManagementSystem != {}
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.informationSecurityManagementSystem.iso27001Certified)
}

message := "The organization has ISO 27001 certification." if {
	compliant
} else := "The organization does not have ISO 27001 certification." if {
	not compliant
}
