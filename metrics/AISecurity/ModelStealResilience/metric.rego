package cch.metrics.model_steal_resilience

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

import input.modelStealResilience as resilience

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "MachineLearningModel"
	resilience
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("modelStealResilience", resilience)]
