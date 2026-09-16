package cch.metrics.security_policy_review_interval_defined

import data.cch.comparison_result
import rego.v1
import input.securityPolicy as securityPolicy

default applicable := false
default compliant := false

applicable if {
      securityPolicy != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("securityPolicy.reviewIntervalMonths", securityPolicy.reviewIntervalMonths)]
