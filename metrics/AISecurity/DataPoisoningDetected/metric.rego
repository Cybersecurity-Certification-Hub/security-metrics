package cch.metrics.data_poisoning_detected

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

import input.poisonedDataLevel as poisoning

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "MachineLearningModel"
	poisoning
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("poisonedDataLevel", poisoning)]
