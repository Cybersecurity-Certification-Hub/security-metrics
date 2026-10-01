package cch.metrics.intrusion_detection_enabled

import data.cch.compare
import rego.v1
import input.accessRestriction.l3Firewall as l3

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "NetworkInterface"
	l3
	l3.intrusionDetectionEnabled != null
}

compliant if {
	input.type[_] == "NetworkInterface"
	l3
	value := l3.intrusionDetectionEnabled
	compare(data.operator, data.target_value, value)
}
