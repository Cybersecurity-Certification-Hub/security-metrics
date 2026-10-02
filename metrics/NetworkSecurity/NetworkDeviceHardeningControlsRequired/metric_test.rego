package cch.metrics.network_device_hardening_controls_required

import rego.v1

test_compliant_when_authorizedSoftwareAndControlledInstallationRequired_is_valid if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {"authorizedSoftwareAndControlledInstallationRequired": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_authorizedSoftwareAndControlledInstallationRequired_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {"authorizedSoftwareAndControlledInstallationRequired": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_authorizedSoftwareAndControlledInstallationRequired_is_missing if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "networkThreatMitigationPolicy": {"authorizedSoftwareAndControlledInstallationRequired": true}}
	not applicable with input as fixture
}
