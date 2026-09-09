package cch.metrics.code_signoff_percentage_last_month

import data.cch.compare
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
    compare(data.operator, data.target_value, cs.percentageLastMonth)
}

results := [comparison_result("codeSignoff.percentageLastMonth", cs.percentageLastMonth)]
