package cch.metrics.iso27001_certification_status

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

applicable if {
	"iso27001Certified" in object.keys(input.informationSecurityManagementSystem)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines whether the organization has ISO 27001 certification for its Information Security Management System." if {
	compliant
} else := "The policy document does not define whether the organization has ISO 27001 certification for its Information Security Management System." if {
	not compliant
}

results := [comparison_result("informationSecurityManagementSystem.iso27001Certified", input.informationSecurityManagementSystem.iso27001Certified)]