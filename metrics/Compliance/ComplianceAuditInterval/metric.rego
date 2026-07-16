package cch.metrics.compliance_audit_interval

import data.cch.compare
import rego.v1
import input.complianceAuditIntervalPolicy as complianceAuditIntervalPolicy

default applicable := false

default compliant := false

applicable if {
    complianceAuditIntervalPolicy != {} # only assess if policy is provided
    "PolicyDocument" in input.type
}

compliant if {
    compare(data.operator, data.target_value, complianceAuditIntervalPolicy.interval)
}

message := "The compliance audit interval is configured within acceptable limits." if {
    compliant
} else := "The compliance audit interval exceeds acceptable limits." if {
    not compliant
}
