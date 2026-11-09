package cch.metrics.adversarial_robustness

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.adversarialRobustnessScore
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("adversarialRobustnessScore", input.adversarialRobustnessScore)]
