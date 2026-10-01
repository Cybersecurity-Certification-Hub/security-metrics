package cch.metrics.device_security_management_policy_complete

import rego.v1

test_compliant_when_mandatedControlsCount_is_valid if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"mandatedControlsCount": 7}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_mandatedControlsCount_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"mandatedControlsCount": 6}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_mandatedControlsCount_is_missing if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "deviceManagementPolicy": {"mandatedControlsCount": 7}}
	not applicable with input as fixture
}
