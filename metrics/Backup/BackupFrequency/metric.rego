package cch.metrics.backup_frequency

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.backup
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.backup.frequency)
}

message := "The policy document defines the backup frequency." if {
	compliant
} else := "The policy document does not define the backup frequency within the specified interval." if {
	not compliant
}
