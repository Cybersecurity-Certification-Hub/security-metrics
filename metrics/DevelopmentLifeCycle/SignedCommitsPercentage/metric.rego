package cch.metrics.signed_commits_percentage

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.signedCommits as sc

default applicable = false

default compliant = false

applicable if {
    sc != {}
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, sc.percentage)
}

results := [comparison_result("signedCommits.percentage", sc.percentage)]
