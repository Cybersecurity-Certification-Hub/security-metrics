package cch.metrics.pull_requests_with_reviews_percentage

import data.cch.compare
import rego.v1
import input.codeRepository.pullRequest as pr

default applicable = false

default compliant = false

applicable if {
	pr
}

compliant if {
	compare(data.operator, data.target_value, pr.reviewPercentage)
}
