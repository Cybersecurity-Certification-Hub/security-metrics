package cch.metrics.code_signoff_percentage

import data.cch.all_compliant
import data.cch.comparison_result
import input.codeSignoff as cs
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"percentage" in object.keys(input.codeSignoff)
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("codeSignoff.percentage", cs.percentage)]
