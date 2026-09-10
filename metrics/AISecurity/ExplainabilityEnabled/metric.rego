package cch.metrics.explainability_enabled

import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
    input.type[_] == "MachineLearningModel"
    input.explainabilityEnabled
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("explainabilityEnabled", input.explainabilityEnabled)]
