package cch.metrics.data_poisoning_detected

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.poisonedDataLevel as poisoning

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	poisoning
}

compliant if {
	compare(data.operator, data.target_value, poisoning)
}

results := [comparison_result("poisonedDataLevel", poisoning)]
