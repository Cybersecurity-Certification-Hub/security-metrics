package cch.metrics.backup_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input as storage

default applicable = false

default compliant = false

applicable if {
	storage.backups != {}
	count(storage.backups) > 0
	"Storage" in storage.type
}

compliant if {
	compare(data.operator, data.target_value, storage.backups[_].enabled)
}

results := [comparison_result("backups.enabled", b.enabled) | b := storage.backups[_]]
