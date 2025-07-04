package cch.metrics.password_rotation_frequency

import data.cch.compare
import rego.v1

default applicable := false

default compliant := false

freq := input.rotationFrequency

applicable if {
	freq
}

compliant if {
	# time.Duration are nanoseconds, we must convert them to hours
	compare(data.operator, data.target_value, time.parse_duration_ns(freq) / (1000000000 * 3600)) # nanoseconds to seconds (/1000000000), seconds to hours (/(3600))
}