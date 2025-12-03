package cch.metrics.encryption_data_rest_policy_q1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:Data.Encryption.mechanism)
}
