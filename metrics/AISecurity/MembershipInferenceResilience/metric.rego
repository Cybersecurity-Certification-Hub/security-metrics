package cch.metrics.membership_inference_resilience

import data.cch.comparison_result
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.membershipInferenceResilience
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("membershipInferenceResilience", input.membershipInferenceResilience)]
