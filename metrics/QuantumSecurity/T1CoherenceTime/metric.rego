package cch.metrics.t_1_coherence_time

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.T1CoherenceTime)
}

results := [comparison_result("T1CoherenceTime", input.T1CoherenceTime)]
