package cch.metrics.security_training_plan_documented

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.training
}

compliant if {
	compare(data.operator, data.target_value, document.training.planDocumented)
}
