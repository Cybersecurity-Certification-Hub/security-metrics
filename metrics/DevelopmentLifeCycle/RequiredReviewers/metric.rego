package cch.metrics.required_reviewers

import data.cch.comparison_result
import rego.v1

default applicable = false

default compliant = false

applicable if {
    "numberOfRequiredReviewers" in object.keys(input)
    "CodeRepository" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("numberOfRequiredReviewers", numberOfRequiredReviewers)]
