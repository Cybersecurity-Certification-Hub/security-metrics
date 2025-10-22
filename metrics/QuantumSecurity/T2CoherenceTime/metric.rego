package cch.metrics.t2_coherence_time

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.T2CoherenceTime)
}
