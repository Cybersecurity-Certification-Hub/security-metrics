package cch.metrics.network_device_hardening_controls_required

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.networkStandard
}

compliant if {
	compare(data.operator, data.target_value, document.networkStandard.authorizedSoftwareAndControlledInstallationRequired)
}
