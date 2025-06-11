package cch.metrics.password_rotation_frequency

import data.cch.compare
import rego.v1

default applicable = false

default compliant = false

freq := input.policyDocument.passwordRotationFrequency

applicable if {
	freq != null
}

compliant if {
	compare(data.operator, data.target_value, freq) 
}