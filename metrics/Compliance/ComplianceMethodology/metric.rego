package cch.metrics.compliance_methodology

import data.cch.compare
import rego.v1
import input.complianceMethodologyPolicy as complianceMethodologyPolicy

default applicable := false

default compliant := false

applicable if {
    complianceMethodologyPolicy != {} # only evaluate if policy is provided
    "PolicyDocument" in input.type
}

compliant if {
    compare(data.operator, data.target_value, complianceMethodologyPolicy.methodology)
}

message := "The compliance methodology is properly configured." if {
    compliant
} else := "The compliance methodology is not properly configured." if {
    not compliant
}
