package cch.metrics.verified_commits_percentage_last_month

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
	every r in results { r.success }
}

results := [comparison_result("verifiedCommits.percentageLastMonth", vc.percentageLastMonth)]
