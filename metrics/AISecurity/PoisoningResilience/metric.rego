package cch.metrics.poisoning_resilience

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false


applicable if {
    input.type[_] == "MachineLearningModel"
    input.poisoningResilienceLevel
}

compliant if {
    compare(data.operator, data.target_value, input.poisoningResilienceLevel)
}

results := [comparison_result("poisoningResilienceLevel", input.poisoningResilienceLevel)]
