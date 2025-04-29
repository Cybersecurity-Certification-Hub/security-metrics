package cch.metrics.one_qubit_gate_error_rate

import data.cch.compare

default applicable = false

default compliant = false

applicable if {
	input.OneQubitGateErrorRate
}

compliant if {
	compare(data.operator, data.target_value, input.OneQubitGateErrorRate)
}
