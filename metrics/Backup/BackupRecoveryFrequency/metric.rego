package cch.metrics.backup_recovery_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input as document
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"recoveryFrequency" in object.keys(input.backup)
	"PolicyDocument" in document.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines the backup recovery frequency." if {
	compliant
} else := "The policy document does not define the backup recovery frequency within the specified interval." if {
	not compliant
}

results := [comparison_result("backup.recoveryFrequency", document.backup.recoveryFrequency)]
