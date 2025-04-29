package cch.metrics.quantum_error_correction_enabled

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.ErrorCorrectionEnabled
}

compliant if {
	compare(data.operator, data.target_value, input.ErrorCorrectionEnabled)
}
