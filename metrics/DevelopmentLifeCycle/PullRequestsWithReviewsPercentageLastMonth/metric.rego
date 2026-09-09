package cch.metrics.pull_requests_with_reviews_percentage_last_month

import data.cch.compare
import rego.v1
import input.reviewPercentageLastMonth as percentage

default applicable = false

default compliant = false

applicable if {
    percentage != {}
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, percentage)
}
