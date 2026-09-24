package cch.metrics.error_correction_enabled

import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("errorCorrectionEnabled", input.errorCorrectionEnabled)]
