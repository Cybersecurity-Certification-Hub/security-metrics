package cch.metrics.encryption_policy_check_q1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
}

compliant if {
    compare(data.operator, data.target_value, document:Data.Encryption.Password.type)
}
