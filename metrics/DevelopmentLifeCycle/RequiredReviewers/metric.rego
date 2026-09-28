package cch.metrics.required_reviewers

import data.cch.comparison_result
import rego.v1
import input.numberOfRequiredReviewers as reviewers

default applicable = false

default compliant = false

applicable if {
    reviewers != {}
    "CodeRepository" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("numberOfRequiredReviewers", reviewers)]
