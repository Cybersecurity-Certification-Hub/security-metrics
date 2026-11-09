package cch.metrics.acceptable_use_policy_scope_coverage

import data.cch.all_compliant
import data.cch.comparison_result
import input.acceptableUsePolicy as acceptableUsePolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"mandatedAreaCoveragePercent" in object.keys(acceptableUsePolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "All three mandated control areas (internet access, email, removable devices) are explicitly addressed." if {
	compliant
} else := "Not all three mandated control areas (internet access, email, removable devices) are explicitly addressed." if {
	not compliant
}

results := [comparison_result("acceptableUsePolicy.mandatedAreaCoveragePercent", acceptableUsePolicy.mandatedAreaCoveragePercent)]
