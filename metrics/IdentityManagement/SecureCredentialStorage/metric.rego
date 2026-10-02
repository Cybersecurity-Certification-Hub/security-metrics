package cch.metrics.secure_credential_storage

import data.cch.comparison_result
import rego.v1
import input.accountManagementPolicy as accountManagementPolicy

default applicable = false
default compliant = false

applicable if {
	"secretStorage" in object.keys(accountManagementPolicy)
	input.type[_] == "PolicyDocument"
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines a tool to be used for secure storage of credentials." if {
	compliant
} else := "The policy document does not define a tool to be used for secure storage of credentials." if {
	not compliant
}

results := [comparison_result("accountManagementPolicy.secretStorage", accountManagementPolicy.secretStorage)]