package cch.metrics.pull_requests_with_reviews_percentage

import data.cch.comparison_result
import rego.v1
import input.reviewPercentage as percentage

default applicable = false

default compliant = false

applicable if {
    percentage != {}
    "CodeRepository" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("reviewPercentage", percentage)]
