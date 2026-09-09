package cch.metrics.explainability_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
    input.type[_] == "MachineLearningModel"
    input.explainabilityEnabled
}

compliant if {
	compare(data.operator, data.target_value, input.explainabilityEnabled)
}

results := [comparison_result("explainabilityEnabled", input.explainabilityEnabled)]
