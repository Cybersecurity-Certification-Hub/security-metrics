package cch.metrics.universal_gate_set_enabled

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

results := [comparison_result("universalGateSetEnabled", input.universalGateSetEnabled)]
