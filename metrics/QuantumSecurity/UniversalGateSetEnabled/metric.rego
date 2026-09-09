package cch.metrics.universal_gate_set_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "QPU"
}

compliant if {
	compare(data.operator, data.target_value, input.UniversalGateSetEnabled)
}

results := [comparison_result("UniversalGateSetEnabled", input.UniversalGateSetEnabled)]
