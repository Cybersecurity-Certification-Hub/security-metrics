package cch.metrics.backup_enabled

import data.cch.compare
import rego.v1
import input.backups as backups

default applicable = false

default compliant = false

applicable if {
	backups
}

compliant if {
	compare(data.operator, data.target_value, backups[_].enabled)
}
