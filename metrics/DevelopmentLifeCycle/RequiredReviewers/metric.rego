package cch.metrics.required_reviewers

import data.cch.compare
import rego.v1
import input.numberOfRequiredReviewers as reviewers

default applicable = false

default compliant = false

applicable if {
    reviewers != {}
    "CodeRepository" in input.type
}

compliant if {
    compare(data.operator, data.target_value, reviewers)
}
