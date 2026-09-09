package cch.metrics.sdlc_checklist_coverage

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.sdlc
}

compliant if {
	compare(data.operator, data.target_value, document.sdlc.checklistCoveragePercent)
}
