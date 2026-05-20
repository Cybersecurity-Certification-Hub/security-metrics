package cch.metrics.code_signoff_percentage_last_month

import data.cch.compare
import rego.v1
import input.codeRepository as repo

default applicable = false

default compliant = false

applicable if {
    repo
    "CodeRepository" in input.type
    repo.codeSignoff
}

compliant if {
    compare(data.operator, data.target_value, repo.codeSignoff.percentageLastMonth)
}
