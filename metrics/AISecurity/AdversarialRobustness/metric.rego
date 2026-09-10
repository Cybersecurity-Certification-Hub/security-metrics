package cch.metrics.adversarial_robustness

import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.adversarialRobustnessScore
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("adversarialRobustnessScore", input.adversarialRobustnessScore)]
