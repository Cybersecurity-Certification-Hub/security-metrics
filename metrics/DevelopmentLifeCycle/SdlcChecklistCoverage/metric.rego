package cch.metrics.sdlc_checklist_coverage

import data.cch.comparison_result
import rego.v1
import input.secureDevelopmentPolicy as secureDevelopmentPolicy

default applicable := false
default compliant := false

applicable if {
	"checklistCoveragePercent" in object.keys(secureDevelopmentPolicy)
	is_number(secureDevelopmentPolicy.checklistCoveragePercent)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "At least 70% of the 10 mandated SDLC checklist items are explicitly present." if {
	compliant
} else := "Fewer than 70% of the 10 mandated SDLC checklist items are explicitly present." if {
	not compliant
}

results := [comparison_result("secureDevelopmentPolicy.checklistCoveragePercent", secureDevelopmentPolicy.checklistCoveragePercent)]
