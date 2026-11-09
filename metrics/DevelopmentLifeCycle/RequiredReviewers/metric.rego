package cch.metrics.required_reviewers

import data.cch.all_compliant
import data.cch.comparison_result
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"numberOfRequiredReviewers" in object.keys(input)
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("numberOfRequiredReviewers", input.numberOfRequiredReviewers)]
