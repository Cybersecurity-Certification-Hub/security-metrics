package cch.metrics.evasion_attack_efficacy

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.evasionEfficacyLevel as evasion

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	evasion
}

compliant if {
	compare(data.operator, data.target_value, evasion)
}

results := [comparison_result("evasionEfficacyLevel", evasion)]
