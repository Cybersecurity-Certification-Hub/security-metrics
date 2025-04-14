package metrics.quantum.reliability

import data.compare

default applicable = false

default compliant = false

applicable if {
	input.TwoQubitGateErrorRate
}

compliant if {
	compare(data.operator, data.target_value, input.TwoQubitGateErrorRate)
}
