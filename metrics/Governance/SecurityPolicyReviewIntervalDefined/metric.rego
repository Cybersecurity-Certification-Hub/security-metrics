package cch.metrics.security_policy_review_interval_defined

import data.cch.all_compliant
import data.cch.comparison_result
import input.securityPolicyReview as securityPolicyReview
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"intervalMonths" in object.keys(securityPolicyReview)
	is_number(securityPolicyReview.intervalMonths)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The Information Security Policy states a review interval within acceptable limits." if {
	compliant
} else := "The Information Security Policy does not state a review interval within acceptable limits." if {
	not compliant
}

results := [comparison_result("securityPolicyReview.intervalMonths", securityPolicyReview.intervalMonths)]
