package cch.metrics.teleworking_two_factor_required

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.teleworking
}

compliant if {
	compare(data.operator, data.target_value, document.teleworking.twoFactorRequired)
}
