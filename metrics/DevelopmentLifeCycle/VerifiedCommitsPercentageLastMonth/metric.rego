package cch.metrics.verified_commits_percentage_last_month

import data.cch.compare
import rego.v1
import input.verifiedCommits as vc

default applicable = false

default compliant = false

applicable if {
    vc
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, vc.percentageLastMonth)
}
