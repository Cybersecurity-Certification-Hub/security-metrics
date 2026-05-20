package cch.metrics.verified_commits_percentage_last_month

import data.cch.compare
import rego.v1
import input.codeRepository as repo

default applicable = false

default compliant = false

applicable if {
    repo
    "CodeRepository" in input.type
    repo.verifiedCommits
}

compliant if {
    compare(data.operator, data.target_value, repo.verifiedCommits.percentageLastMonth)
}
