package cch.metrics.code_signoff_percentage

import data.cch.comparison_result
import rego.v1
import input.codeSignoff as cs

default applicable = false

default compliant = false

applicable if {
    cs != {}
    "CodeRepository" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("codeSignoff.percentage", cs.percentage)]
