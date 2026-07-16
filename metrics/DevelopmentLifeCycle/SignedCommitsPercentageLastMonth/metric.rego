package cch.metrics.signed_commits_percentage_last_month

import data.cch.compare
import rego.v1
import input.signedCommits as sc

default applicable = false

default compliant = false

applicable if {
    sc
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, sc.percentageLastMonth)
}
