package cch.metrics.acceptable_use_policy_scope_coverage

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.acceptableUse
}

compliant if {
	compare(data.operator, data.target_value, document.acceptableUse.mandatedAreaCoveragePercent)
}
