package cch.metrics.secure_credential_storage

import data.cch.all_compliant
import data.cch.comparison_result
import input.accountManagementPolicy as accountManagementPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"secretStorage" in object.keys(accountManagementPolicy)
	input.type[_] == "PolicyDocument"
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines a tool to be used for secure storage of credentials." if {
	compliant
} else := "The policy document does not define a tool to be used for secure storage of credentials." if {
	not compliant
}

results := [comparison_result("accountManagementPolicy.secretStorage", accountManagementPolicy.secretStorage)]
