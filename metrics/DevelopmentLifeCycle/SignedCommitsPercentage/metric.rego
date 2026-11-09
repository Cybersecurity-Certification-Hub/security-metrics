package cch.metrics.signed_commits_percentage

import data.cch.all_compliant
import data.cch.comparison_result
import input.signedCommits as sc
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"percentage" in object.keys(sc)
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("signedCommits.percentage", sc.percentage)]
