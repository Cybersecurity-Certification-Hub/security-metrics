package cch.metrics.audit_log_review_process_documented

import data.cch.comparison_result
import rego.v1
import input.logManagement as logManagement

default applicable := false
default compliant := false

applicable if {
      logManagement != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("logManagement.periodicAnomalyReviewRequired", logManagement.periodicAnomalyReviewRequired)]
