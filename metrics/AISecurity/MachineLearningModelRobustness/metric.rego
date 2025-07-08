package cch.metrics.machine_learning_model_robustness

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.robustness.adversarialRobustnessTested == true
	input.robustness.metricType
	input.robustness.metricValue
}

compliant if {

	input.robustness.metricType == "CleverScore"
	compare(">=", 0.5, input.robustness.metricValue)
} else if {
	input.robustness.metricType == "SPADEScore"
	compare(">=", 0.5, input.robustness.metricValue)
} 
