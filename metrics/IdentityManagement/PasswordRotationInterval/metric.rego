package cch.metrics.password_rotation_interval

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

pwd := input.passwordBasedAuthentication

applicable if {
	pwd
}

compliant if {
	# rotationInterval is in days
	compare(data.operator, data.target_value, pwd.rotationInterval)
}