package cch.metrics.poisoning_resilience

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.poisoningResilienceLevel
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("poisoningResilienceLevel", input.poisoningResilienceLevel)]
