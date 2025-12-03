package cch.metrics.backup_monitoring_policy_check_q4

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:Data.Backup.transmissionInterval)
}
