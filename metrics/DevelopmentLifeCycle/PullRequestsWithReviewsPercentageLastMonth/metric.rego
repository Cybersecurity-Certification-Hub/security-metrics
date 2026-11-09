package cch.metrics.pull_requests_with_reviews_percentage_last_month

import data.cch.all_compliant
import data.cch.comparison_result
import input.reviewPercentageLastMonth as percentage
import rego.v1

default applicable := false

default compliant := false

applicable if {
	percentage != {}
	"CodeRepository" in input.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("reviewPercentageLastMonth", percentage)]
