package cch.metrics.verified_commits_percentage

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.verifiedCommits as vc

default applicable = false

default compliant = false

applicable if {
    vc != {}
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, vc.percentage)
}

results := [comparison_result("verifiedCommits.percentage", vc.percentage)]
