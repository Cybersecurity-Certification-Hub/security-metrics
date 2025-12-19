package cch.metrics.explainability_enabled

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false

applicable if {
    input.type[_] == "MachineLearningModel"
    input.explanabilityEnabled
}

compliant if {
	compare(data.operator, data.target_value, input.explanabilityEnabled)
}
