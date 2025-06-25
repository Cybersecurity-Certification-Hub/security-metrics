package cch.metrics.rotation_frequency

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

freq := input.policyDocument.rotationFrequency

applicable if {
	freq
}

compliant if {
	compare(data.operator, data.target_value, freq) 
}