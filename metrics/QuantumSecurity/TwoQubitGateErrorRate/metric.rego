package cch.metrics.two_qubit_gate_error_rate

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.TwoQubitGateErrorRate)
}

results := [comparison_result("TwoQubitGateErrorRate", input.TwoQubitGateErrorRate)]
