package cch.metrics.audit_access_unrestricted_clause_present

import data.cch.comparison_result
import rego.v1
import input.complianceAuditIntervalPolicy as complianceAuditIntervalPolicy

default applicable := false
default compliant := false

applicable if {
	"unrestrictedAccessGranted" in object.keys(complianceAuditIntervalPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The clause grants direct, unrestricted, on-demand access to supervisory/inspection entities." if {
	compliant
} else := "The clause does not grant direct, unrestricted, on-demand access to supervisory/inspection entities." if {
	not compliant
}

results := [comparison_result("complianceAuditIntervalPolicy.unrestrictedAccessGranted", complianceAuditIntervalPolicy.unrestrictedAccessGranted)]
