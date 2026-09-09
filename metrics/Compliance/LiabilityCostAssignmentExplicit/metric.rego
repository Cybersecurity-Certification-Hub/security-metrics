package cch.metrics.liability_cost_assignment_explicit

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.liabilityClause
}

compliant if {
	compare(data.operator, data.target_value, document.liabilityClause.costsExplicitlyAssignedToProvider)
}
