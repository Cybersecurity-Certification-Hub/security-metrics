package cch.metrics.signed_commits_percentage_last_month

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
	every r in results { r.success }
}

results := [comparison_result("signedCommits.percentageLastMonth", sc.percentageLastMonth)]
