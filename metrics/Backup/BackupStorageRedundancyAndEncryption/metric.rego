package cch.metrics.backup_storage_redundancy_and_encryption

import data.cch.comparison_result
import rego.v1
import input.backup as backup

default applicable := false
default compliant := false

applicable if {
	"redundant" in object.keys(backup)
	is_string(backup.redundant)
	"enabled" in object.keys(backup.transportEncryption)
	"PolicyDocument" in input.type
}

compliant if {
	backup.transportEncryption.enabled == true
	every r in results { r.success }
}

message := "Backups are stored on redundant and encrypted systems." if {
	compliant
} else := "Backups are not stored on redundant and encrypted systems." if {
	not compliant
}

results := [
	comparison_result("backup.redundant", backup.redundant)
]
