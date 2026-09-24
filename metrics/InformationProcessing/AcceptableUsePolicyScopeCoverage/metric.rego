package cch.metrics.acceptable_use_policy_scope_coverage

import data.cch.comparison_result
import rego.v1
import input.acceptableUsePolicy as acceptableUsePolicy

default applicable := false
default compliant := false

applicable if {
	"mandatedAreaCoveragePercent" in object.keys(acceptableUsePolicy)
	is_number(acceptableUsePolicy.mandatedAreaCoveragePercent)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "All three mandated control areas (internet access, email, removable devices) are explicitly addressed." if {
	compliant
} else := "Not all three mandated control areas (internet access, email, removable devices) are explicitly addressed." if {
	not compliant
}

results := [comparison_result("acceptableUsePolicy.mandatedAreaCoveragePercent", acceptableUsePolicy.mandatedAreaCoveragePercent)]
