package cch.metrics.t_2_coherence_time

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

results := [comparison_result("t2CoherenceTime", input.t2CoherenceTime)]
