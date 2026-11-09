package cch.metrics.error_correction_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"errorCorrectionEnabled" in object.keys(input)
	input.type[_] == "QPU"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("errorCorrectionEnabled", input.errorCorrectionEnabled)]
