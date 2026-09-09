package cch.metrics.membership_inference_resilience

import data.cch.compare
import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.membershipInferenceResilience
}

compliant if {
	compare(data.operator, data.target_value, input.membershipInferenceResilience)
}

results := [comparison_result("membershipInferenceResilience", input.membershipInferenceResilience)]
