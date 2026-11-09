package cch.metrics.compliance_methodology

import data.cch.all_compliant
import data.cch.comparison_result
import input.complianceMethodologyPolicy as complianceMethodologyPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"methodology" in object.keys(input.complianceMethodologyPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The compliance methodology is properly configured." if {
	compliant
} else := "The compliance methodology is not properly configured." if {
	not compliant
}

results := [comparison_result("complianceMethodologyPolicy.methodology", complianceMethodologyPolicy.methodology)]
