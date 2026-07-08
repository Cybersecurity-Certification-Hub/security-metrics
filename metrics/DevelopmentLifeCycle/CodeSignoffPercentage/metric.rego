package cch.metrics.code_signoff_percentage

import data.cch.compare
import rego.v1
import input.codeSignoff as cs

default applicable = false

default compliant = false

applicable if {
    cs
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, cs.percentage)
}
