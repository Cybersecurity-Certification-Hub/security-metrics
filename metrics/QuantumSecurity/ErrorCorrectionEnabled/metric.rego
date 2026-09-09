package cch.metrics.error_correction_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.ErrorCorrectionEnabled)
}

results := [comparison_result("ErrorCorrectionEnabled", input.ErrorCorrectionEnabled)]
