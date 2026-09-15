package cch.metrics.backup_recovery_frequency

import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.backup != {}
	"PolicyDocument" in document.type
	document.backup.recoveryFrequency != {}
	document.backup.recoveryFrequency != null
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines the backup recovery frequency." if {
	compliant
} else := "The policy document does not define the backup recovery frequency within the specified interval." if {
	not compliant
}

results := [comparison_result("backup.recoveryFrequency", document.backup.recoveryFrequency)]
