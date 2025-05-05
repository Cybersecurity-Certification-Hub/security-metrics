package cch.metrics.quantum_spam_error_rate

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.SPAMErrorRate)
}
