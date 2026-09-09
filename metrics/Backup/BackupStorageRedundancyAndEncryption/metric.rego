package cch.metrics.backup_storage_redundancy_and_encryption

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.backupPolicy
}

compliant if {
	compare(data.operator, data.target_value, document.backupPolicy.redundantAndEncrypted)
}
