package cch.metrics.backup_enabled

import data.cch.comparison_result
import rego.v1
import input as storage

default applicable = false

default compliant = false

applicable if {
	"backups" in object.keys(input)
	count(storage.backups) > 0
	"Storage" in input.type
}

compliant if {
	some r in results
	r.success
}

results := [comparison_result("backups.enabled", b.enabled) | b := storage.backups[_]]
