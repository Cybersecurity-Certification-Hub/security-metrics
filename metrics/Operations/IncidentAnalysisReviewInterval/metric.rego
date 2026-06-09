package cch.metrics.incident_analysis_frequency_q1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document:SecurityIncident.Procedure.reviewInterval)
}
