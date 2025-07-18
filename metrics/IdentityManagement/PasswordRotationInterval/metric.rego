package cch.metrics.password_rotation_interval

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

int := input.rotationInterval

applicable if {
	# check resource type
	"PolicyDocument" in document.type
}

compliant if {
	# rotationInterval is in days
	compare(data.operator, data.target_value, int.passwordBasedAuthentication.rotationInterval)
}