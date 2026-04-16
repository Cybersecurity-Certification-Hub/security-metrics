package cch.metrics.data_confidentiality_sdn_policy_presence

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    compare(data.operator, data.target_value, document.DataConfidentialitySDNPolicy.isDefined)
}
