package cch.metrics.machine_learning_model_adversarial_robustness

import data.cch.compare
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
