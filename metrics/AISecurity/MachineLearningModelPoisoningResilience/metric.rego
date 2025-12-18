package cch.metrics.machine_learning_model_poisoning_resilience

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false


applicable if {
    input.poisoningResilienceLevel
}

compliant if {
    compare(data.operator, data.target_value, input.poisoningResilienceLevel)
}
