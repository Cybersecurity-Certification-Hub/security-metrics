package cch.metrics.signed_commits_percentage

import data.cch.compare
import rego.v1
import input.codeRepository.SignedCommits as sc

default applicable = false

default compliant = false

applicable if {
	sc
}

compliant if {
	compare(data.operator, data.target_value, sc.percentage)
}
