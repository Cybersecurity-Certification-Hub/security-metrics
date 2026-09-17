package cch.metrics.approved_commit_author_enforced

import data.cch.comparison_result
import rego.v1
import input.approvedCommitAuthorEnforced as author

default applicable = false

default compliant = false

applicable if {
    author != {}
    "CodeRepository" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("approvedCommitAuthorEnforced", author)]
