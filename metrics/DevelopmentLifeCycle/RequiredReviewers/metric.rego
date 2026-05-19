package cch.metrics.required_reviewers

import data.cch.compare
import rego.v1
import input.codeRepository as codeRepo

default applicable = false

default compliant = false

applicable if {
	codeRepo
}

compliant if {
	compare(data.operator, data.target_value, codeRepo.numberOfRequiredReviewers)
}
