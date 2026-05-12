package cch.metrics.code_signoff_percentage

import data.cch.compare
import rego.v1
import input.codeRepository.codeSignoff as cs

default applicable = false

default compliant = false

applicable if {
	cs
}

compliant if {
	compare(data.operator, data.target_value, cs.percentage)
}
