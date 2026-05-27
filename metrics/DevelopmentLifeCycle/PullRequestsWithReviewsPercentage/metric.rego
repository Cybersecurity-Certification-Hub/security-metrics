package cch.metrics.pull_requests_with_reviews_percentage

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

applicable if {
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, input.reviewPercentage)
}
