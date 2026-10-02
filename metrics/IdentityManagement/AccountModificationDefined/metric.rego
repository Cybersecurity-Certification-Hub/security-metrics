package cch.metrics.account_modification_defined

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
	compare(data.operator, data.target_value, document.accountManagementPolicy.modificationDefined)
}

message := "The policy document defines procedures for account modification." if {
	compliant
} else := "The policy document does not define procedures for account modification." if {
	not compliant
}
