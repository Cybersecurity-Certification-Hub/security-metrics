package cch.metrics.password_length

import data.cch.all_compliant
import data.cch.comparison_result
import input.passwordBasedAuthentication as pwd
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"length" in object.keys(pwd)
	input.type[_] == "PolicyDocument"
}

compliant if {
	all_compliant(results)
}

message := "The policy document defines the length of passwords set to a sensible minimum value of characters." if {
	compliant
} else := "The policy document does not define the length of passwords set to a sensible minimum value of characters." if {
	not compliant
}

results := [comparison_result("passwordBasedAuthentication.length", pwd.length)]
