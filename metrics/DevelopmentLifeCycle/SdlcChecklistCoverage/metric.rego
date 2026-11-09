package cch.metrics.sdlc_checklist_coverage

import data.cch.all_compliant
import data.cch.comparison_result
import input.secureDevelopmentPolicy as secureDevelopmentPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"checklistCoveragePercent" in object.keys(secureDevelopmentPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "At least 70% of the 10 mandated SDLC checklist items are explicitly present." if {
	compliant
} else := "Fewer than 70% of the 10 mandated SDLC checklist items are explicitly present." if {
	not compliant
}

results := [comparison_result("secureDevelopmentPolicy.checklistCoveragePercent", secureDevelopmentPolicy.checklistCoveragePercent)]
