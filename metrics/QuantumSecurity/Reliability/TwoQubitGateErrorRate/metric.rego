package cch.metrics.two_qubit_error_rate

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.TwoQubitGateErrorRate
}

compliant if {
	compare(data.operator, data.target_value, input.TwoQubitGateErrorRate)
}
