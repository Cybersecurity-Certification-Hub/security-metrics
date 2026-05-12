package cch.metrics.required_reviewers

import data.cch.compare
import rego.v1
import input.codeRepository.reviewer as rev

default applicable = false

default compliant = false

applicable if {
	rev
}

compliant if {
	compare(data.operator, data.target_value, rev.numberOfReviewer)
}
