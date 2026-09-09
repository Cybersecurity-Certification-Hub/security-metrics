package cch.metrics.approved_commit_author_enforced

import data.cch.compare
import rego.v1
import input.approvedCommitAuthorEnforced as author

default applicable = false

default compliant = false

applicable if {
    author != {}
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, author)
}
