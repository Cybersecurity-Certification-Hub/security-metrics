package cch.metrics.password_length

import data.cch.comparison_result
import rego.v1
import input.passwordBasedAuthentication as pwd

default applicable = false
default compliant = false

applicable if {
	"length" in object.keys(pwd)
	input.type[_] == "PolicyDocument"
}

compliant if {
	every r in results { r.success }
}

message := "The policy document defines the length of passwords set to a sensible minimum value of characters." if {
	compliant
} else := "The policy document does not define the length of passwords set to a sensible minimum value of characters." if {
	not compliant
}

results := [comparison_result("passwordBasedAuthentication.length", pwd.length)]
