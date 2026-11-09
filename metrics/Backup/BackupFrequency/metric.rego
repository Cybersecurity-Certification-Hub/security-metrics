package cch.metrics.backup_frequency

import data.cch.all_compliant
import data.cch.comparison_result
import input as document
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"frequency" in object.keys(input.backup)
	"PolicyDocument" in document.type
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines the backup frequency." if {
	compliant
} else := "The policy document does not define the backup frequency within the specified interval." if {
	not compliant
}

results := [comparison_result("backup.frequency", document.backup.frequency)]
