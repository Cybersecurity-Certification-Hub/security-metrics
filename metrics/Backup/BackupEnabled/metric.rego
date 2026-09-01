package cch.metrics.backup_enabled

import data.cch.compare
import rego.v1
import input as storage

default applicable = false

default compliant = false

applicable if {
	storage.backups != {}
	"Storage" in storage.type
}

compliant if {
	compare(data.operator, data.target_value, storage.backups[_].enabled)
}
