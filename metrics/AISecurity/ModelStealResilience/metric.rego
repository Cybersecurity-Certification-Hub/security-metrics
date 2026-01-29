package cch.metrics.model_steal_resilience

import data.cch.compare
import rego.v1

import input.modelStealResilience as resilience

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	resilience
}

compliant if {
	compare(data.operator, data.target_value, resilience)
}
