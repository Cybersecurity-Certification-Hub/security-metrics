package cch.metrics.compliance_methodology

import data.cch.comparison_result
import rego.v1
import input.complianceMethodologyPolicy as complianceMethodologyPolicy

default applicable := false

default compliant := false

applicable if {
    complianceMethodologyPolicy != {} # only assess if policy is provided
    "PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The compliance methodology is properly configured." if {
    compliant
} else := "The compliance methodology is not properly configured." if {
    not compliant
}

results := [comparison_result("complianceMethodologyPolicy.methodology", complianceMethodologyPolicy.methodology)]
