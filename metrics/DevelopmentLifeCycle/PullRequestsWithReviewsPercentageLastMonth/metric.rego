package cch.metrics.pull_requests_with_reviews_percentage_last_month

import data.cch.compare
import rego.v1
import input.codeRepository as repo

default applicable = false

default compliant = false

applicable if {
    repo
    "CodeRepository" in input.type
    repo.pullRequest
}

compliant if {
    compare(data.operator, data.target_value, repo.pullRequest.reviewPercentageLastMonth)
}
