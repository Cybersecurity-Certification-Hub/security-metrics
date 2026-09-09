package cch.metrics.adversarial_robustness

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.adversarialRobustnessScore
}

compliant if {
	compare(data.operator, data.target_value, input.adversarialRobustnessScore)
}

results := [comparison_result("adversarialRobustnessScore", input.adversarialRobustnessScore)]
