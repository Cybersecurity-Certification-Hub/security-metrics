package cch.metrics.compliance_methodology

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
    compare(data.operator, data.target_value, compliance.methodology)
}

message := "Compliance methodology is properly configured." if {
    compliant
} else := "Compliance methodology is not properly configured." if {
    not compliant
}
