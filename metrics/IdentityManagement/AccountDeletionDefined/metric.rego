package cch.metrics.account_deletion_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
	document.accountManagementPolicy != {}
	"PolicyDocument" in document.type
}

compliant if {
	compare(data.operator, data.target_value, document.accountManagementPolicy.deletionDefined)
}

message := "The policy document defines procedures for account deletion." if {
	compliant
} else := "The policy document does not define procedures for account deletion." if {
	not compliant
}
