package cch.metrics.approved_commit_author_enforced

import data.cch.all_compliant
import data.cch.comparison_result
import input.approvedCommitAuthorEnforced as author
import rego.v1

default applicable := false

default compliant := false

applicable if {
	author != {}
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("approvedCommitAuthorEnforced", author)]
