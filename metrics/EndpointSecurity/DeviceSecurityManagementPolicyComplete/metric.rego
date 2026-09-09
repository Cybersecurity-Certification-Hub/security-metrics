package cch.metrics.device_security_management_policy_complete

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.deviceManagement
}

compliant if {
	compare(data.operator, data.target_value, document.deviceManagement.allMandatedControlsAddressed)
}
