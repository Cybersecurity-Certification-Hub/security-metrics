package cch.metrics.compliance_audit_interval

import data.cch.comparison_result
import rego.v1
import input.complianceAuditIntervalPolicy as complianceAuditIntervalPolicy

default applicable := false

default compliant := false

applicable if {
    complianceAuditIntervalPolicy != {} # only assess if policy is provided
    "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The compliance audit interval is configured within acceptable limits." if {
    compliant
} else := "The compliance audit interval exceeds acceptable limits." if {
    not compliant
}

results := [comparison_result("complianceAuditIntervalPolicy.auditInterval", complianceAuditIntervalPolicy.auditInterval)]
