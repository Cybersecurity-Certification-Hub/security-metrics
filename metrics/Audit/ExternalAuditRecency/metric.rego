package cch.metrics.external_audit_recency

import data.cch.all_compliant
import data.cch.comparison_result
import input.complianceAuditIntervalPolicy as complianceAuditIntervalPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"daysSinceLastAudit" in object.keys(complianceAuditIntervalPolicy)
	is_number(complianceAuditIntervalPolicy.daysSinceLastAudit)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The last completed external audit occurred within the required window." if {
	compliant
} else := "The last completed external audit did not occur within the required window." if {
	not compliant
}

results := [comparison_result("complianceAuditIntervalPolicy.daysSinceLastAudit", complianceAuditIntervalPolicy.daysSinceLastAudit)]
