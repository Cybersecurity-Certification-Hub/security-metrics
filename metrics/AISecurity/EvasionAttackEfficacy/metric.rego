package cch.metrics.evasion_attack_efficacy

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

import input.evasionEfficacyLevel as evasion

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "MachineLearningModel"
	evasion
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("evasionEfficacyLevel", evasion)]
