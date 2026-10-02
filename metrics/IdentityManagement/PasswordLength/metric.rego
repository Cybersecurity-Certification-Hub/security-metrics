package cch.metrics.password_length

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

pwd := input.passwordBasedAuthentication

applicable if {
	"length" in object.keys(pwd)
}

compliant if {
	# length is in characters
	compare(data.operator, data.target_value, pwd.length)
}