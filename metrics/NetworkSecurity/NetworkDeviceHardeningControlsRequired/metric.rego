package cch.metrics.network_device_hardening_controls_required

import data.cch.comparison_result
import rego.v1
import input.networkThreatMitigationPolicy as networkThreatMitigationPolicy

default applicable := false
default compliant := false

applicable if {
	"authorizedSoftwareAndControlledInstallationRequired" in object.keys(networkThreatMitigationPolicy)
	is_boolean(networkThreatMitigationPolicy.authorizedSoftwareAndControlledInstallationRequired)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The standard requires authorized-software/anti-malware controls and controlled hardware/software installation on network devices." if {
	compliant
} else := "The standard does not require authorized-software/anti-malware controls and controlled hardware/software installation on network devices." if {
	not compliant
}

results := [comparison_result("networkThreatMitigationPolicy.authorizedSoftwareAndControlledInstallationRequired", networkThreatMitigationPolicy.authorizedSoftwareAndControlledInstallationRequired)]
