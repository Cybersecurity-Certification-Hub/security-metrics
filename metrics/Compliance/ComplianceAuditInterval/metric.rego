package cch.metrics.compliance_audit_interval

import data.cch.all_compliant
import data.cch.comparison_result
import input.complianceAuditIntervalPolicy as complianceAuditIntervalPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"auditInterval" in object.keys(input.complianceAuditIntervalPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The compliance audit interval is configured within acceptable limits." if {
	compliant
} else := "The compliance audit interval exceeds acceptable limits." if {
	not compliant
}

results := [comparison_result("complianceAuditIntervalPolicy.auditInterval", complianceAuditIntervalPolicy.auditInterval)]
