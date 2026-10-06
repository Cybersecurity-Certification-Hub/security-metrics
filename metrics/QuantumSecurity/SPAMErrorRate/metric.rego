package cch.metrics.spam_error_rate

import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	"spamErrorRate" in object.keys(input)
	input.type[_] == "QPU"
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("spamErrorRate", input.spamErrorRate)]
