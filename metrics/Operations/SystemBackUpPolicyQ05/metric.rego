package cch.metrics.system_back_up_policy_q05

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:Data.Backup.interval)
}
