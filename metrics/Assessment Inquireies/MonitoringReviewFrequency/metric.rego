package cch.metrics.monitoring_review_frequency

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
  compare(data.operator, data.target_value, document.MonitoringProcedure.reviewInterval)
}

message := "Monitoring procedures are reviewed frequently enough to ensure compliance." if {
  compliant
} else := "Monitoring procedures are not reviewed frequently enough to ensure compliance. Review frequency should be within the specified interval." if {
  not compliant
}

