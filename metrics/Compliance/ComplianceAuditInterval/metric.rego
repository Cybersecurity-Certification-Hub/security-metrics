package cch.metrics.compliance_audit_interval

import data.cch.compare
import rego.v1
import input.compliance as compliance

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in input.type
    compliance != {} # only evaluate if compliance policy is provided
}

compliant if {
    compare(data.operator, data.target_value, compliance.interval)
}

message := "Compliance audit interval is configured within acceptable limits." if {
    compliant
} else := "Compliance audit interval exceeds acceptable limits." if {
    not compliant
}
