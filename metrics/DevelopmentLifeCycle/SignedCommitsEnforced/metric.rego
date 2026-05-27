package cch.metrics.signed_commits_enforced

import data.cch.compare
import rego.v1
import input.codeRepository.signedCommits as repo

default applicable = false

default compliant = false

applicable if {
    repo
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, repo.enforced)
}
