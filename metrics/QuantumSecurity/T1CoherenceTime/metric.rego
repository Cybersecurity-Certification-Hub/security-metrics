package cch.metrics.t_1_coherence_time

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"t1CoherenceTime" in object.keys(input)
	input.type[_] == "QPU"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("t1CoherenceTime", input.t1CoherenceTime)]
