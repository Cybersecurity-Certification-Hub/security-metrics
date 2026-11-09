package cch.metrics.verified_commits_percentage_last_month

import data.cch.all_compliant
import data.cch.comparison_result
import input.verifiedCommits as vc
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"percentageLastMonth" in object.keys(vc)
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("verifiedCommits.percentageLastMonth", vc.percentageLastMonth)]
